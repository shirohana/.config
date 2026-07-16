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
