---@type LazyPluginSpec
local LuaDev = {
  -- https://github.com/folke/neodev.nvim
  'folke/neodev.nvim',
  opts = {
    experimental = { pathStrict = true },
  },
}

return LuaDev
