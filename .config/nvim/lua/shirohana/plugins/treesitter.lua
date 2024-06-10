---@type LazyPluginSpec
local TreeSitter = {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    -- Plugins.TreeSitterIndentObject,
    -- Plugins.TreeSitterRainbow,
    -- Plugins.TreeSitterTextobjects,
  },
  event = { 'BufNewFile', 'BufReadPost' },
  ---@type TSConfig
  opts = {
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
    highlight = {
      enable = true,
      disable = { 'help', 'markdown', 'plantuml', 'stylus', 'vimdoc' },
    },
    indent = { enable = true, disable = {} },
    -- autotag = { enable = true },
    -- playground = { enable = true },
    -- rainbow = { enable = true },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['ab'] = '@block.outer',
          ['ib'] = '@block.inner',
          ['a0'] = '@conditional.outer',
          ['i0'] = '@conditional.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
        },
        selection_modes = {
          ['@block.outer'] = 'V',
          ['@conditional.outer'] = 'V',
          ['@function.outer'] = 'V',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_previous_start = {
          ['[['] = '@block.outer',
          ['[c'] = '@class.outer',
          ['[]'] = '@function.outer',
          ['[f'] = '@function.outer',
        },
        goto_next_start = {
          [']]'] = '@block.outer',
          [']c'] = '@class.outer',
          [']f'] = '@function.outer',
          [']['] = '@function.outer',
        },
      },
    },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}

---@type LazyPluginSpec
local TreeSitterContext = {
  -- https://github.com/nvim-treesitter/nvim-treesitter-context
  'nvim-treesitter/nvim-treesitter-context',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    max_lines = 6,
  },
}

return { TreeSitter, TreeSitterContext }
