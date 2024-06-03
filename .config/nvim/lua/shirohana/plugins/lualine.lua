---@type LazyPluginSpec
local Lualine = {
  -- https://github.com/nvim-lualine/lualine.nvim
  'nvim-lualine/lualine.nvim',
  ---@todo wip
  enabled = false,
  dependencies = {
    'catppuccin/nvim',
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
  config = function(_, opts)
    local macchiato = require("catppuccin.palettes").get_palette "macchiato"
    require("lualine").setup(opts)
  end,
}

return Lualine
