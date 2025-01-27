-- stylua: ignore
local WilderGradient = {
  '#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
  '#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
  '#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
  '#c8d43a', '#bfde43', '#b6e84e', '#aff05b',
}

---@type LazyPluginSpec
local Wilder = {
  -- https://github.com/gelguy/wilder.nvim
  'gelguy/wilder.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'romgrk/fzy-lua-native',
  },
  event = 'CmdlineEnter',
  opts = {
    modes = { ':', '/', '?' },
    next_key = '<C-n>',
    accept_key = '<Tab>',
    previous_key = '<C-p>',
  },
  config = function(_, opts)
    local wilder = require 'wilder'

    wilder.setup(opts)

    wilder.set_option('pipeline', {
      wilder.branch(
        wilder.cmdline_pipeline {
          -- sets the language to use, 'vim' and 'python' are supported
          language = 'python',
          -- 0 turns off fuzzy matching
          -- 1 turns on fuzzy matching
          -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
          fuzzy = 1,
        },
        wilder.python_search_pipeline {
          -- can be set to wilder#python_fuzzy_delimiter_pattern() for stricter fuzzy matching
          -- pattern = wilder.python_fuzzy_pattern(),
          pattern = wilder.python_fuzzy_delimiter_pattern(),
          -- omit to get results in the order they appear in the buffer
          sorter = wilder.python_difflib_sorter(),
          -- can be set to 're2' for performance, requires pyre2 to be installed
          -- see :h wilder#python_search() for more details
          engine = 're',
        }
      ),
    })

    local gradient = {}
    for i, fg in ipairs(WilderGradient) do
      gradient[i] = wilder.make_hl(
        'WilderGradient' .. i,
        'Pmenu',
        { { a = 1 }, { a = 1 }, { foreground = fg } }
      )
    end

    wilder.set_option(
      'renderer',
      wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
        reverse = 1,
        border = 'rounded',
        empty_message = wilder.popupmenu_empty_message(),
        highlighter = wilder.highlighter_with_gradient { wilder.basic_highlighter() },
        highlights = { gradient = gradient },
        left = {
          ' ',
          wilder.popupmenu_devicons(),
          wilder.popupmenu_buffer_flags {
            flags = ' a+ ',
            icons = { ['+'] = '+', a = '*', h = '.' },
          },
        },
        right = {
          ' ',
          wilder.popupmenu_scrollbar(),
        },
      })
    )
  end,
}

return Wilder
