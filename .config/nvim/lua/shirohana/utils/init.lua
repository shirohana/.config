local M = {}

local has_local_prettier = nil

local function detect_local_prettier()
  if has_local_prettier == nil then
    local script = [[
      const path = require('path');
      const root = path.parse(process.cwd()).root;
      let cpath = process.cwd(), max = 10, meta;
      while (cpath !== root && max --> 0) {
        try {
          meta = require(path.join(cpath, 'package.json'));
          break;
        } catch (e) {}
        cpath = path.dirname(cpath);
      }
      process.stdout.write(meta && 'prettier' in (meta?.devDependencies || {}) ? 'true' : 'false');
    ]]
    local cmd = 'node <<EOF\n' .. script .. '\nEOF'
    local handle = io.popen(cmd)
    local result = nil
    if handle then
      result = handle:read '*a'
      handle:close()
    end
    has_local_prettier = result == 'true'
  end
  return has_local_prettier
end

M.save_with_formatting = function()
  local should_format = true
  if vim.tbl_contains({ 'javascript', 'typescript', 'typescriptreact' }, vim.bo.filetype) then
    should_format = detect_local_prettier()
  end
  if should_format then
    vim.lsp.buf.format { timeout_ms = 5000 }
  end
  vim.cmd 'write'
end

M.save_without_formatting = function()
  local strip_ws_enabled = vim.b['strip_whitespace_on_save']
  if strip_ws_enabled then
    vim.cmd 'DisableStripWhitespaceOnSave'
  end
  vim.cmd 'write'
  if strip_ws_enabled then
    vim.cmd 'EnableStripWhitespaceOnSave'
  end
end

return M
