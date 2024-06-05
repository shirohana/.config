---@type LazyPluginSpec
local Colorizer = {
  -- https://github.com/NvChad/nvim-colorizer.lua
  'NvChad/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    user_default_options = {
      css = true,
      tailwind = true,
      sass = { enable = false, parsers = { 'css' } },
    },
  },
}

return Colorizer
