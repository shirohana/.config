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
      path_display = { 'smart' },
      -- path_display = { 'filename_first' },
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
    local telescope = require('telescope')
    telescope.setup(opts)
    telescope.load_extension 'fzf'
    local builtin = require('telescope.builtin')
    local keymap = vim.keymap
    keymap.set('n', '<C-p>', builtin.find_files, { desc = 'Find files' })
    keymap.set('n', '<C-o>', builtin.buffers, { desc = 'Find files in buffers' })
    keymap.set('n', '<M-f>', builtin.live_grep, { desc = 'Live grep' })
    keymap.set('v', '<M-f>', builtin.grep_string, { desc = 'Grep string from visual selection' })
    keymap.set('n', 'ss', builtin.current_buffer_fuzzy_find, { desc = 'Current buffer fuzzy find' })
  end,
}



---@type LazyPluginSpec
local TelescopeFzfNative = {
  -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
  'nvim-telescope/telescope-fzf-native.nvim',
  build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
}

return { Telescope, TelescopeFzfNative }
