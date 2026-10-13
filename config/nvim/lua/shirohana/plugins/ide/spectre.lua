---@type LazyPluginSpec
local Spectre = {
  -- https://github.com/nvim-pack/nvim-spectre
  'nvim-pack/nvim-spectre',
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = true,
}

return Spectre
