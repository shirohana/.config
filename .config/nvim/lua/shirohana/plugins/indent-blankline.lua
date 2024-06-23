---@type LazyPluginSpec
local _IndentBlankline_v2 = {
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  'lukas-reineke/indent-blankline.nvim',
  version = '2',
  enabled = 'NeoSolarized' == require('shirohana.config').colorscheme,
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

---@type LazyPluginSpec
local _IndentBlankline_v3 = {
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  'lukas-reineke/indent-blankline.nvim',
  enabled = 'catppuccin' == require('shirohana.config').colorscheme,
  main = 'ibl',
  opts = {
    indent = {
      highlight = { 'Whitespace', 'CursorColumn' },
      char = '',
    },
    whitespace = {
      highlight = { 'Whitespace', 'CursorColumn' },
      remove_blankline_trail = false,
    },
    scope = { enabled = false },
  },
}

local IndentBlankline = 'NeoSolarized' == require('shirohana.config').colorscheme
    and _IndentBlankline_v2
  or _IndentBlankline_v3

return IndentBlankline
