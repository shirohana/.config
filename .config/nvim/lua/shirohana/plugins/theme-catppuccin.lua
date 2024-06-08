---@type LazyPluginSpec
local Catppuccin = {
  -- https://github.com/catppuccin/nvim
  'catppuccin/nvim',
  name = 'catppuccin',
  enabled = 'catppuccin' == require('shirohana.config').colorscheme,
  priority = 1000,
  opts = {
    flavour = 'macchiato',
    transparent_background = true,
    show_end_of_buffer = true,
    integrations = {
      notify = true,
    },
  },
}

return Catppuccin
