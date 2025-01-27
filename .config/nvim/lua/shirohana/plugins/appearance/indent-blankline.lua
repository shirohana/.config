---@type LazyPluginSpec
local IndentBlankline = {
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  'lukas-reineke/indent-blankline.nvim',
  enabled = 'catppuccin' == require('shirohana.config').colorscheme,
  main = 'ibl',
  opts = {
    scope = { enabled = true },
  },
}

return IndentBlankline
