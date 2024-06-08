local Keys = require('shirohana.core.constants').Keys

---@type LazyPluginSpec
local NeoTree = {
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  'nvim-neo-tree/neo-tree.nvim',

  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },

  keys = {
    { Keys['<M-;>'], '<Cmd>Neotree toggle<CR>', { desc = 'Toggle NeoTree' } },
    { Keys['<M-:>'], '<Cmd>Neotree reveal<CR>', { desc = 'Find current file in NeoTree' } },
  },

  opts = {
    use_default_mappings = false,
    window = {
      width = 36,
      mappings = {
        -- ['g?'] = 'show_help',
        ['o'] = 'open',
        -- ['s'] = 'open_vsplit',
        -- ['S'] = 'open_split',
        ['<CR>'] = 'toggle_preview',
        ['x'] = 'close_node',
        ['zM'] = 'close_all_nodes',
        ['zR'] = 'expand_all_nodes',
        ['zm'] = 'close_all_nodes',
        ['zr'] = 'expand_all_nodes',
        ['ma'] = { 'add', config = { show_path = 'relative' } },
        ['mc'] = { 'copy', config = { show_path = 'relative' } },
        ['mm'] = { 'move', config = { show_path = 'relative' } },
        ['md'] = 'delete',
        ['y'] = 'copy_to_clipboard',
        ['c'] = 'cut_to_clipboard',
        ['p'] = 'paste_from_clipboard',
        ['q'] = 'close_window',
        ['R'] = 'refresh',
        ['['] = 'prev_source',
        [']'] = 'next_source',
      },
    },
    filesystem = {
      bind_to_cwd = false,
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignore = false,
      },
      window = {
        mappings = {
          ['i'] = 'toggle_hidden',
          [Keys['<M-f>']] = 'fuzzy_finder',
          ['fd'] = 'fuzzy_finder_directory',
          ['ff'] = 'filter_on_submit',
          ['<C-x>'] = 'clear_filter',
          ['U'] = 'navigate_up',
          ['C'] = 'set_root',
          ['me'] = 'open_with_edit',
          [';k'] = 'prev_git_modified',
          [';j'] = 'next_git_modified',
        },
      },
      commands = {
        open_with_edit = function(state)
          local node = state.tree:get_node()
          vim.cmd('edit ' .. node.path)
        end,
      },
    },
  },
}

return NeoTree
