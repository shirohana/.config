local Plugins = require('vars').Plugins

---@type LazyPluginSpec
local TreeSitter = {
  Plugins.TreeSitter,
  build = ':TSUpdate',
  event = { 'BufNewFile', 'BufReadPost' },
  dependencies = {
    Plugins.TreeSitterIndentObject,
    -- Plugins.TreeSitterRainbow,
    Plugins.TreeSitterTextobjects,
  },
  ---@type TSConfig
  opts = {
    ensure_installed = {
      'dockerfile',
      'json',
      'lua',
      -- 'markdown',
      'python',
      'query',
      'toml',
      'tsx',
      'typescript',
      'vim',
      'yaml',
    },
    autotag = { enable = true },
    highlight = {
      enable = true,
      disable = { 'help', 'plantuml', 'stylus' },
    },
    indent = { enable = true, disable = {} },
    playground = { enable = true },
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
  Plugins.TreeSitterContext,
  dependencies = { Plugins.TreeSitter },
  config = true,
}

return { TreeSitter, TreeSitterContext }
