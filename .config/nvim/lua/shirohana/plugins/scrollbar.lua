local Colors = require('shirohana.core.constants').Colors

---@type LazyPluginSpec
local Scrollbar = {
  -- https://github.com/petertriho/nvim-scrollbar
  'petertriho/nvim-scrollbar',
  dependencies = {
    'kevinhwang91/nvim-hlslens',
  },
  event = 'BufReadPre',
  opts = {
    handle = { text = ' ', color = '#0b4f60' },
    marks = {
      Cursor = { text = '□', priority = 5, color = Colors.cyan },
      Search = { text = { '◇', '◆' }, priority = 1, color = Colors.blue },
      Error = { text = { '□', '■' }, priority = 2, color = Colors.red },
      Warn = { text = { '□', '■' }, priority = 3, color = Colors.yellow },
      Info = { text = { '-', '=' }, priority = 4, color = nil },
      Hint = { text = { '-', '=' }, priority = 5, color = nil },
      Misc = { text = { '-', '=' }, priority = 6, color = nil },
      GitAdd = { text = '▏', priority = 7, color = Colors.green },
      GitChange = { text = '▏', priority = 7, color = Colors.yellow },
      GitDelete = { text = '▏', priority = 7, color = Colors.red },
    },
    excluded_buftypes = { 'nofile', 'terminal' },
    excluded_filetypes = { 'LspsagaHover', 'noice', 'prompt', 'Telescope' },
    autocmd = {
      render = {
        'BufWinEnter',
        'TabEnter',
        'TermEnter',
        'WinEnter',
        'CmdwinLeave',
        'TextChanged',
        'VimResized',
        'WinScrolled',
      },
      clear = {
        'BufWinLeave',
        'TabLeave',
        'TermLeave',
        'WinLeave',
      },
    },
    handlers = {
      cursor = true,
      diagnostic = true,
      gitsigns = true,
      handle = true,
      search = true,
    },
  },
}

return Scrollbar
