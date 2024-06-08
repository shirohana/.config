---@type LazyPluginSpec
local Lualine = {
  -- https://github.com/nvim-lualine/lualine.nvim
  'nvim-lualine/lualine.nvim',
  enabled = require('shirohana.config').USE_LUALINE,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    extensions = {
      'ctrlspace',
      'fugitive',
      'lazy',
      'mason',
      'neo-tree',
      'oil',
      'symbols-outline',
      'trouble',
    },
  },
}

return Lualine
