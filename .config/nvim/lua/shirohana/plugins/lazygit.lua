---@type LazyPluginSpec
local LazyGit = {
  -- https://github.com/kdheepak/lazygit.nvim
  'kdheepak/lazygit.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { '<leader>g', '<Cmd>LazyGit<CR>', desc = 'LazyGit' },
  },
}

return LazyGit
