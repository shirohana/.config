---@type LazyPluginSpec
local IndentBlankline = {
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = 'BufReadPre',
  config = true,
}

return IndentBlankline
