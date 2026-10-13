# TypeScript in Neovim: surviving the TS 7 split

Notes from fixing a broken `ts_ls` on 2026-07-16, and the setup that lets TypeScript 5
and TypeScript 7 projects coexist. Written so it can be applied to a second machine from
scratch.

## The symptom

Open any TypeScript file, get this:

```
vim.schedule callback: .../lua/vim/lsp/client.lua:581: RPC[Error] code_name = InternalError,
message = "Request initialize failed with message: Could not find a valid TypeScript
installation. Please ensure that the \"typescript\" dependency is installed in the
workspace or that a valid `tsserver.path` is specified. Exiting."
```

It appears right after a Mason "Upgrade all". Nothing in your own config changed.

## Why it happens

**TypeScript 7 is not a version bump — it's the native (Go) port.** It ships a compiled
binary instead of the old JavaScript `tsserver`. Compare the `lib/` directories:

```
# typescript@5.9.3               # typescript@7.0.2
lib/tsserver.js      ← exists    lib/getExePath.js
lib/typescript.js                lib/tsc.js
lib/tsc.js                       lib/version.cjs
lib/lib.es5.d.ts ...             (no tsserver.js — the real binary lives in
                                  @typescript/typescript-<platform>-<arch>/lib/tsc)
```

`typescript-language-server` drives TypeScript by loading `lib/tsserver.js`. Under TS 7
that file does not exist, so it aborts during `initialize` — hence the error.

Now the trigger. Mason's `typescript-language-server` package declares an *extra package*
of `typescript` with **no version constraint**, so it resolves to npm `latest`. Once TS 7
went stable, any reinstall silently pulled it:

```jsonc
// mason-receipt.json
"source": { "raw": { "extra_packages": ["typescript"], "id": "pkg:npm/typescript-language-server@5.3.0" } }
"registry": { "version": "2026-07-13-stable-calf" }
```

```jsonc
// the package.json Mason generated — note the ^7
"dependencies": { "typescript": "^7.0.2", "typescript-language-server": "^5.3.0" }
```

**Why it was fatal rather than a graceful fallback.** `typescript-language-server` also
looks for a TypeScript in the workspace. In a pnpm monorepo there is no
`node_modules/typescript` at the repo root — it lives in the package
(`apps/<app>/node_modules/typescript`, itself a symlink into `.pnpm/`). So the workspace
lookup missed *and* the bundled copy was TS 7. Both resolution paths dead, so it exited
instead of degrading.

## Part 1 — unbreak `ts_ls` (the 30-second fix)

Pin the Mason copy back to the TypeScript 5 line:

```bash
cd "$(nvim --headless -c 'lua io.write(vim.fn.stdpath("data"))' -c q 2>&1)/mason/packages/typescript-language-server"
npm install typescript@5
```

Verify the file that was missing is back:

```bash
ls node_modules/typescript/lib/tsserver.js   # should exist
node -p "require('./node_modules/typescript/package.json').version"   # 5.9.3
```

> ⚠️ **This recurs.** The pin lives in that package's `package.json`, but Mason regenerates
> it from the registry spec on the next `:MasonUpdate` / "Upgrade all", which still asks for
> `typescript` unversioned. If TS breaks again after an upgrade, re-run the two lines above.
> This looks like an upstream registry bug and may get fixed there.

## Part 2 — run TS 5 and TS 7 side by side

Part 1 only restores TS 5. For a TS 7 project you need a different server, because
**TS 7 serves LSP itself**:

```bash
node_modules/.bin/tsc --lsp --stdio    # speaks JSON-RPC; no typescript-language-server involved
```

So these are not two versions of one server — they are two different servers, and the
config has to pick one per project:

| Project's TypeScript | Server   | Binary                                              |
| -------------------- | -------- | --------------------------------------------------- |
| 5.x, or none         | `ts_ls`  | Mason's `typescript-language-server` + bundled TS 5 |
| 7.x                  | `tsgo`   | the project's own `node_modules/.bin/tsc --lsp --stdio` |

Two design choices worth keeping:

- **Detect by walking up from the buffer, not from the git root.** That's what makes a pnpm
  monorepo resolve the package's TypeScript through its symlink instead of finding nothing
  at the root — the exact reason the original failure was fatal.
- **`tsgo` spawns the *project-local* `tsc`.** No Mason package, no global install, so the
  server version always matches the project and there's nothing for Mason to clobber.
  Using `node_modules/.bin/tsc` (the npm shim) rather than the raw
  `@typescript/typescript-<platform>-<arch>/lib/tsc` binary keeps this portable across
  machines and architectures.

### `lua/shirohana/lsp/typescript.lua` (new)

Shared version detection.

```lua
local M = {}

---Resolve the TypeScript installation that governs a buffer.
---Walks up from the buffer's own directory rather than the git root, so that
---monorepos (pnpm workspaces) resolve the package's TypeScript, not the root's.
---@param bufnr integer
---@return { dir: string, bin: string, version: string, major: integer }|nil
function M.resolve(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name == '' then
    return nil
  end

  local current = vim.fs.dirname(name)

  while current do
    local pkg = current .. '/node_modules/typescript/package.json'

    if vim.uv.fs_stat(pkg) then
      local ok, decoded = pcall(function()
        return vim.json.decode(table.concat(vim.fn.readfile(pkg), '\n'))
      end)

      local version = ok and decoded and decoded.version
      local major = version and tonumber(version:match '^(%d+)')

      if major then
        return {
          dir = current,
          bin = current .. '/node_modules/.bin/tsc',
          version = version,
          major = major,
        }
      end
    end

    local parent = vim.fs.dirname(current)
    if parent == current then
      break
    end
    current = parent
  end

  return nil
end

---TypeScript 7 is the native (Go) port: it ships no `lib/tsserver.js` and instead
---serves LSP itself via `tsc --lsp --stdio`, so it needs a different server than
---`typescript-language-server`.
---@param bufnr integer
---@return boolean
function M.is_native(bufnr)
  local ts = M.resolve(bufnr)
  return ts ~= nil and ts.major >= 7
end

return M
```

### `lua/shirohana/lsp/config/ts_ls.lua` (gated)

The gate is `root_dir`'s function form. Neovim documents it as the per-buffer activation
switch: **not calling `on_dir()` means the server doesn't start for that buffer.**

```lua
local typescript = require 'shirohana.lsp.typescript'

---@type vim.lsp.ClientConfig
return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  -- Yield to `tsgo` on TypeScript 7 projects; serve everything else, including
  -- loose files with no local install (Mason bundles a TypeScript 5 fallback).
  root_dir = function(bufnr, on_dir)
    if typescript.is_native(bufnr) then
      return
    end

    on_dir(vim.fs.root(bufnr, { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' }))
  end,
  init_options = {
    hostInfo = 'neovim',
  },
}
```

### `lua/shirohana/lsp/config/tsgo.lua` (new)

`cmd` takes a function form receiving `config`, which is what lets it resolve a
per-project binary at start time.

```lua
local typescript = require 'shirohana.lsp.typescript'

---TypeScript 7's native server, spoken by the project's own `tsc` binary.
---There is no Mason package and no global install: the binary is always the
---project-local one, so the server version always matches the project version.
---@type vim.lsp.ClientConfig
return {
  cmd = function(dispatchers, config)
    return vim.lsp.rpc.start({ config.root_dir .. '/node_modules/.bin/tsc', '--lsp', '--stdio' }, dispatchers)
  end,
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  -- Activate only on TypeScript 7 projects. The root is the directory owning
  -- `node_modules`, which keeps `cmd` able to find the binary from `root_dir`.
  root_dir = function(bufnr, on_dir)
    local ts = typescript.resolve(bufnr)

    if ts and ts.major >= 7 then
      on_dir(ts.dir)
    end
  end,
}
```

Because the two gates are exact complements, `ts_ls` and `tsgo` can never both attach.

> This config auto-registers every `.lua` under `lua/shirohana/lsp/config/` via
> `vim.lsp.enable()` in `lua/shirohana/lsp/init.lua`. Dropping in `tsgo.lua` is enough —
> no wiring needed. On a setup that lists servers explicitly, add `tsgo` to that list.

## Verifying it on a new machine

Build two fixtures with the same error and check that the right server attaches to each:

```bash
for v in 5.9 7; do
  d=$(mktemp -d) && cd "$d" && npm init -y >/dev/null && npm install typescript@$v >/dev/null
  echo '{ "compilerOptions": { "strict": true, "noEmit": true } }' > tsconfig.json
  printf 'const greeting: string = 42;\nexport function hello(name: string): number {\n  return name;\n}\n' > main.ts
  echo "==> typescript@$v fixture at $d"
done
```

Open `main.ts` from each and list what attached:

```vim
:lua =vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = 0 }))
```

Expected: `{ "null-ls", "ts_ls" }` in the 5.9 fixture, `{ "null-ls", "tsgo" }` in the 7
fixture, and three diagnostics in both. Other clients (`null-ls`, `eslint`, …) attach
alongside and are fine — what matters is that exactly one of `ts_ls` / `tsgo` is present.

> Don't check with `vim.lsp.get_clients({ bufnr = 0 })[1].name` — client order isn't
> guaranteed, so it happily reports `null-ls` and tells you nothing.

Results observed on the original machine (nvim 0.12.2, macOS arm64):

| Project              | Detected  | Attached | Diagnostics |
| -------------------- | --------- | -------- | ----------- |
| fixture              | 5.9.3     | `ts_ls`  | 3 ✅        |
| fixture              | 7.0.2     | `tsgo`   | 3 ✅        |
| real pnpm monorepo   | 5.7.3 @ `apps/mms-fe` | `ts_ls` | 0 (clean file) ✅ |

## Scope note

What was verified: `typescript-language-server@5.3.0` fails against `typescript@7.0.2`, and
TS 7.0.2's `tsc --lsp --stdio` completes an LSP `initialize` and serves diagnostics. Whether
some future `typescript-language-server` release adds TS 7 support was **not** checked — if
it ever does, the `tsgo` config stays valid regardless, since it talks to TypeScript directly.

## Versions in play

| Thing                        | Version                     |
| ---------------------------- | --------------------------- |
| Neovim                       | 0.12.2                      |
| Mason registry (the culprit) | `2026-07-13-stable-calf`    |
| typescript-language-server   | 5.3.0                       |
| typescript (broke it)        | 7.0.2                       |
| typescript (pinned back to)  | 5.9.3                       |
