---@type LazyPluginSpec
local Telescope = {
  -- https://github.com/nvim-telescope/telescope.nvim
  'nvim-telescope/telescope.nvim',
  tag = '0.1.6',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzf-native.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
  },

  opts = {
    defaults = {
      scroll_strategy = 'limit',
      path_display = { 'filename_first' },
      layout_strategy = 'flex',
      sorting_strategy = 'ascending',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_cutoff = 0,
        },
        vertical = {
          prompt_position = 'top',
          preview_cutoff = 0,
        },
      },
    },
    pickers = {
      find_files = { hidden = true },
      live_grep = { hidden = true },
      grep_string = { hidden = true },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  },

  config = function(_, opts)
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local Keys = require('shirohana.core.constants').Keys

    telescope.setup(opts)
    telescope.load_extension 'fzf'

    local keymap = vim.keymap.set

    keymap('n', 'ss', builtin.current_buffer_fuzzy_find, { desc = 'Current buffer fuzzy find' })

    if 'Telescope' == require('shirohana.config').FILE_EXPLORER then
      keymap('n', '<C-p>', builtin.find_files, { desc = 'Find files' })
      keymap('n', '<C-o>', builtin.buffers, { desc = 'Find files in buffers' })
      keymap('n', Keys['<M-f>'], builtin.live_grep, { desc = 'Live grep' })
      keymap('v', Keys['<M-f>'], builtin.grep_string, { desc = 'Grep string' })
    end
  end,
}

---@type LazyPluginSpec
local TelescopeFzfNative = {
  -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
  'nvim-telescope/telescope-fzf-native.nvim',
  build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
}

return { Telescope, TelescopeFzfNative }
