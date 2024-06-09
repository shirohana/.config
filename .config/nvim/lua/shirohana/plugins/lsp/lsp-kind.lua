---@type LazyPluginSpec
local LspKind = {
  -- https://github.com/onsails/lspkind-nvim
  'onsails/lspkind-nvim',
  opts = {
    symbol_map = require('shirohana.core.constants').Icons,
  },
  config = function(_, opts)
    require('lspkind').init(opts)
  end,
}

return LspKind
