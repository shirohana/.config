---@type LazyPluginSpec
local Trouble = {
  -- https://github.com/folke/trouble.nvim
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  cmd = 'Trouble',
  config = true,
}

return Trouble
