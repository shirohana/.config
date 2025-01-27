---@type LazyPluginSpec
local TreeSitter = {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  event = { 'BufNewFile', 'BufReadPost' },
  cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
  lazy = vim.fn.argc(-1) == 0,
  ---@type TSConfig
  opts = {
    highlight = {
      enable = true,
      disable = { 'help', 'markdown', 'plantuml', 'stylus', 'vimdoc' },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<BS>',
        node_incremental = '<BS>',
        scope_incremental = false,
        node_decremental = '<S-BS>',
      },
    },
    indent = { enable = true, disable = {} },
    ensure_installed = {
      'css',
      'dockerfile',
      'html',
      'json',
      'lua',
      'markdown',
      'markdown_inline',
      'python',
      'query',
      'scss',
      'svelte',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'yaml',
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['ad'] = '@conditional.outer',
          ['id'] = '@conditional.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
        },
        selection_modes = {
          ['@conditional.outer'] = 'V',
          ['@function.outer'] = 'V',
          ['@class.outer'] = 'V',
          ['@block.outer'] = 'V',
        },
      },
      move = {
        enable = true,
        goto_next = {
          [']d'] = '@conditional.outer',
        },
        goto_previous = {
          ['[d'] = '@conditional.outer',
        },
        goto_next_start = {
          [']a'] = '@parameter.inner',
          [']f'] = '@function.outer',
          [']c'] = '@class.outer',
        },
        goto_next_end = {
          [']A'] = '@parameter.inner',
          [']F'] = '@function.outer',
          [']C'] = '@class.outer',
        },
        goto_previous_start = {
          ['[a'] = '@parameter.inner',
          ['[f'] = '@function.outer',
          ['[c'] = '@class.outer',
        },
        goto_previous_end = {
          ['[A'] = '@parameter.inner',
          ['[F'] = '@function.outer',
          ['[C'] = '@class.outer',
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}

---@type LazyPluginSpec
local TreeSitterTextObject = {
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  'nvim-treesitter/nvim-treesitter-textobjects',
  event = 'VeryLazy',
}

return { TreeSitter, TreeSitterTextObject }
