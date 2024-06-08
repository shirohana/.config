---@type LazyPluginSpec
local IndentBlankline = {
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  'lukas-reineke/indent-blankline.nvim',
  version = '2',
  event = 'BufReadPre',
  opts = {
    space_char_blankline = ' ',
    show_current_context = true,
    show_current_context_start = true,
    char = '',
    char_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
    },
    space_char_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
    },
    show_trailing_blankline_indent = false,
  },
  init = function()
    vim.cmd [[
      highlight IndentBlanklineIndent1 guibg=#002b36 gui=nocombine
      highlight IndentBlanklineIndent2 guibg=#073642 gui=nocombine
    ]]
  end,
}

return IndentBlankline
