local Keys = require('shirohana.core.constants').Keys

---@type LazyPluginSpec
local Outline = {
  -- https://github.com/hedyhli/outline.nvim
  'hedyhli/outline.nvim',
  keys = {
    { 'K', '<Cmd>Outline<CR>' },
  },
  opts = {
    autofold_depth = 2,
    keymaps = {
      close = { '<Esc>', 'q', 'K' },
      goto_location = 'o',
      focus_location = 'p',
      hover_symbol = 'd<Space>',
      toggle_preview = '<CR>',
      rename_symbol = 'r',
      code_actions = 'zi',
      fold = { 'h', 'x' },
      -- unfold = 'l',
      -- fold_all = 'W',
      -- unfold_all = 'E',
      -- fold_reset = 'R',
    },
  },
}

return Outline
