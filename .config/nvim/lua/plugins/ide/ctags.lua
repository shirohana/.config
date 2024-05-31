local Plugins = require('vars').Plugins

---@type LazyPluginSpec
local SymbolsOutline = {
  Plugins.SymbolsOutline,
  keys = {
    { 'K', '<Cmd>SymbolsOutline<CR>' },
  },
  opts = {
    autofold_depth = 2,
    keymaps = {
      close = { '<Esc>', 'q', 'K' },
      goto_location = 'o',
      focus_location = 'p',
      hover_symbol = 'd<Space>',
      toggle_preview = '<Cr>',
      rename_symbol = '®', -- <Opt+r>
      code_actions = 'zi',
      fold = { 'h', 'x' },
      -- unfold = 'l',
      -- fold_all = 'W',
      -- unfold_all = 'E',
      -- fold_reset = 'R',
    },
  },
}

return { SymbolsOutline }
