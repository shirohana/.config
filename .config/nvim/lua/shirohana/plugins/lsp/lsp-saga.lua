local Icons = require('shirohana.core.constants').Icons

---@type LazyPluginSpec
local LspSaga = {
  -- https://github.com/nvimdev/lspsaga.nvim
  'tami5/lspsaga.nvim',
  lazy = true,
  opts = {
    border_style = 'round',
    code_action_icon = string.format('%s ', Icons.Action),
    diagnostic_header_icon = string.format(' %s  ', Icons.Bug),
  },
}

return LspSaga
