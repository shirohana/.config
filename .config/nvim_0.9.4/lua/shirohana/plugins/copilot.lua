---@type LazyPluginSpec
local Copilot = {
  -- https://github.com/github/copilot.vim
  'github/copilot.vim',
  enabled = 'Copilot' == require('shirohana.config').CODE_COMPLETION_AI,
  cmd = 'Copilot',
  event = 'BufEnter',
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
