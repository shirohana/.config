---@type LazyPluginSpec
local Copilot = {
  -- https://github.com/github/copilot.vim
  'github/copilot.vim',
  cmd = 'Copilot',
  event = 'InsertEnter',
  init = function()
    vim.g.copilot_filetypes = {
      gitcommit = true,
      markdown = true,
      yaml = true,
      ['neo-tree'] = false,
      [''] = true,
    }
  end,
}

return Copilot
