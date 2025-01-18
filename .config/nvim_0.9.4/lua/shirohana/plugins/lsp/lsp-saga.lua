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
  init = function()
    if require('shirohana.config').USE_LSP_SAGA_KEYMAPS then
      local Keys = require('shirohana.core.constants').Keys
      local keymap = vim.keymap.set
      keymap('n', 'd<Space>', '<Cmd>Lspsaga hover_doc<CR>')
      keymap('n', 'zj', '<Cmd>Lspsaga diagnostic_jump_next<CR>')
      keymap('n', 'zk', '<Cmd>Lspsaga diagnostic_jump_prev<CR>')
      keymap('n', 'zi', '<Cmd>Lspsaga code_action<CR>')
      keymap('n', 'zo', '<Cmd>Lspsaga show_line_diagnostics<CR>')
      keymap('n', Keys['<M-r>'], '<Cmd>Lspsaga rename<CR>')
    end
  end,
}

return LspSaga
