# todo-comments.nvim — `Invalid 'end_col': out of range` in wide keyword highlights

## Summary

`todo-comments.nvim` crashes with `Invalid 'end_col': out of range` when the
highlight `pattern` is configured so that a match can end at the very last byte
of a line, AND `highlight.keyword` is set to one of the wide modes (`wide`,
`wide_bg`, `wide_fg`).

The default `pattern` requires a trailing `:`, which masks the bug, so it does
not appear with stock config. Any user-supplied pattern that drops the
mandatory trailing character (e.g. making the colon optional) will trigger it.

## Repository

`folke/todo-comments.nvim`

## Affected file

`lua/todo-comments/highlight.lua`

## Reproduction

1. Use a config where `highlight.pattern` allows a match to end at EOL. The
   minimal change from defaults is making the trailing colon optional:

   ```lua
   require("todo-comments").setup({
     highlight = {
       keyword = "wide_fg",                  -- or "wide" / "wide_bg"
       pattern = [[.*<(KEYWORDS)\s*:?]],     -- default is `\s*:` (colon required)
     },
   })
   ```

2. Open any buffer (e.g. a Lua file) and type a line where the keyword sits at
   the very end of the line, with no trailing characters:

   ```
   -- TODO
   ```

3. Crash:

   ```
   vim.schedule callback: .../lazy/todo-comments.nvim/lua/todo-comments/highlight.lua:94: Invalid 'end_col': out of range
   stack traceback:
           [C]: in function 'nvim_buf_set_extmark'
           .../highlight.lua:94: in function 'add_highlight'
           .../highlight.lua:248: in function 'highlight'
           .../highlight.lua:155: in function ''
           vim/_core/editor.lua: in function <vim/_core/editor.lua:0>
   ```

## Root cause

In `M.highlight` (the buffer-range highlight loop), after the match is found,
`start` and `finish` are converted to 0-indexed byte positions:

```lua
start = start - 1
finish = finish - 1
```

`match` (`m[2]`) is the keyword group only — e.g. `"TODO"` — so `finish` ends
up at the byte position immediately after the keyword.

The `wide`, `wide_bg`, `wide_fg` branches then extend the highlight by one
column on each side:

```lua
-- highlight.lua, around lines 246-248
if hl.keyword == "wide" or hl.keyword == "wide_bg" then
  add_highlight(buf, Config.ns, hl_bg, lnum, math.max(start - 1, 0), finish + 1)
elseif hl.keyword == "wide_fg" then
  add_highlight(buf, Config.ns, hl_fg, lnum, math.max(start - 1, 0), finish + 1)
end
```

The leading side already clamps with `math.max(start - 1, 0)`. The trailing
side does **not** clamp. When the keyword sits at the end of the line,
`finish == #line`, so `finish + 1 == #line + 1`, which exceeds the line length
and `nvim_buf_set_extmark` rejects it with `Invalid 'end_col': out of range`.

The default `highlight.pattern` is `[[.*<(KEYWORDS)\s*:]]`, which forces at
least a `:` to follow the keyword, so `finish + 1 ≤ #line` always holds with
the default. The bug is therefore latent and only surfaces with custom patterns
that allow a trailing-character-free match (e.g. `\s*:?`, or a pattern that
matches `@TODO` or `TODO` standalone at EOL).

## Suggested fix

Mirror the existing leading-side clamp on the trailing side, using `math.min`
against `#line`. The `line` variable is already in scope at the call sites.

```diff
--- a/lua/todo-comments/highlight.lua
+++ b/lua/todo-comments/highlight.lua
@@ -243,11 +243,11 @@ function M.highlight(buf, first, last, _event)

         -- tag highlights
         if hl.keyword == "wide" or hl.keyword == "wide_bg" then
-          add_highlight(buf, Config.ns, hl_bg, lnum, math.max(start - 1, 0), finish + 1)
+          add_highlight(buf, Config.ns, hl_bg, lnum, math.max(start - 1, 0), math.min(finish + 1, #line))
         elseif hl.keyword == "wide_fg" then
-          add_highlight(buf, Config.ns, hl_fg, lnum, math.max(start - 1, 0), finish + 1)
+          add_highlight(buf, Config.ns, hl_fg, lnum, math.max(start - 1, 0), math.min(finish + 1, #line))
         elseif hl.keyword == "bg" then
           add_highlight(buf, Config.ns, hl_bg, lnum, start, finish)
         elseif hl.keyword == "fg" then
           add_highlight(buf, Config.ns, hl_fg, lnum, start, finish)
         end
```

This is a minimal, allocation-free fix that matches the symmetry of the
existing `math.max(start - 1, 0)` clamp on the other side.

### Alternative: defensive clamp inside `add_highlight`

A more thorough fix is to clamp inside `add_highlight` itself, so any future
caller is also safe. Costs one extra buffer read per call:

```lua
local function add_highlight(buf, ns, hl, line, from, to)
  local lines = vim.api.nvim_buf_get_lines(buf, line, line + 1, false)
  local line_len = lines[1] and #lines[1] or 0
  vim.api.nvim_buf_set_extmark(buf, ns, line, from, {
    end_col = math.min(to, line_len),
    hl_group = hl,
    priority = 500,
  })
end
```

I'd recommend the call-site fix — it's the smallest possible diff, no perf
cost, and the only two unsafe call sites are the two `wide_*` branches. The
other `add_highlight` callers in the same function pass `finish` (≤ `#line`)
or `#line` directly, both of which are already valid.

## Test plan

- With the patch and `pattern = [[.*<(KEYWORDS)\s*:?]]`, the line `-- TODO`
  alone no longer crashes; the keyword highlight is rendered up to EOL.
- Default config behavior (`pattern = [[.*<(KEYWORDS)\s*:]]`) is unchanged
  because `finish + 1 ≤ #line` already held there, so `math.min` is a no-op.
- `wide` / `wide_bg` / `wide_fg` all behave identically (the same clamp is
  applied to all three).

## Notes for the PR

- Keep the diff to the two lines above. No refactor.
- The commit message can be one line, e.g.:
  `fix(highlight): clamp wide keyword end_col to line length`
- Mention the repro pattern (`\s*:?` or any pattern allowing match at EOL) in
  the PR body so reviewers can reproduce without guessing.
- Worth a quick `gh issue list --repo folke/todo-comments.nvim --search "end_col"`
  and `gh pr list --repo folke/todo-comments.nvim --search "end_col"` before
  opening, in case there's already an issue/PR open.
