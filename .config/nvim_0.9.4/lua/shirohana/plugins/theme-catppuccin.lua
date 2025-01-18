---@type LazyPluginSpec
local Catppuccin = {
  -- https://github.com/catppuccin/nvim
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    flavour = 'macchiato',
    transparent_background = true,
    show_end_of_buffer = true,
    integrations = {
      navic = true,
      notify = true,
    },
  },
}

return Catppuccin
