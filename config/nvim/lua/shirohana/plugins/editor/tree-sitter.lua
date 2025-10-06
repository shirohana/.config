local ensure_installed = {
  'css',
  'dockerfile',
  'html',
  'javascript',
  'javascriptreact',
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
  'typescriptreact',
  'vim',
  'yaml',
}

---@type LazyPluginSpec
local TreeSitter = {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  lazy = false,
  config = function(_, opts)
    local ts = require 'nvim-treesitter'

    ts.setup(opts)
    ts.install(ensure_installed)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = ensure_installed,
      callback = function()
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}

-- opts = {
--     highlight = {
--       enable = true,
--       disable = { 'help', 'markdown', 'plantuml', 'vimdoc' },
--     },
--     indent = { enable = true, disable = {} },
--     spell = {
--       enable = true,
--       disable = { 'markdown' },
--     },
--     ensure_installed = {
--       'css',
--       'dockerfile',
--       'html',
--       'javascript',
--       'javascriptreact',
--       'json',
--       'lua',
--       'markdown',
--       'markdown_inline',
--       'python',
--       'query',
--       'scss',
--       'svelte',
--       'toml',
--       'tsx',
--       'typescript',
--       'typescriptreact',
--       'vim',
--       'yaml',
--     },
--     incremental_selection = {
--       enable = true,
--       keymaps = {
--         init_selection = '<BS>',
--         node_incremental = '<BS>',
--         scope_incremental = false,
--         node_decremental = '<S-BS>',
--       },
--     },
--     textobjects = {
--       select = {
--         enable = true,
--         lookahead = true,
--         keymaps = {
--           ['ad'] = '@conditional.outer',
--           ['id'] = '@conditional.inner',
--           ['af'] = '@function.outer',
--           ['if'] = '@function.inner',
--           ['ac'] = '@class.outer',
--           ['ic'] = '@class.inner',
--           ['ab'] = '@block.outer',
--           ['ib'] = '@block.inner',
--         },
--         selection_modes = {
--           ['@conditional.outer'] = 'V',
--           ['@function.outer'] = 'V',
--           ['@class.outer'] = 'V',
--           ['@block.outer'] = 'V',
--         },
--       },
--       move = {
--         enable = true,
--         goto_next = {
--           [']d'] = '@conditional.outer',
--         },
--         goto_previous = {
--           ['[d'] = '@conditional.outer',
--         },
--         goto_next_start = {
--           [']a'] = '@parameter.inner',
--           [']f'] = '@function.outer',
--           [']c'] = '@class.outer',
--         },
--         goto_next_end = {
--           [']A'] = '@parameter.inner',
--           [']F'] = '@function.outer',
--           [']C'] = '@class.outer',
--         },
--         goto_previous_start = {
--           ['[a'] = '@parameter.inner',
--           ['[f'] = '@function.outer',
--           ['[c'] = '@class.outer',
--         },
--         goto_previous_end = {
--           ['[A'] = '@parameter.inner',
--           ['[F'] = '@function.outer',
--           ['[C'] = '@class.outer',
--         },
--       },
--     },
--   },

return TreeSitter

-- ---@type LazyPluginSpec
-- local TreeSitter = {
--   -- https://github.com/nvim-treesitter/nvim-treesitter
--   'nvim-treesitter/nvim-treesitter',
--   branch = 'main',
--   build = ':TSUpdate',
--   -- dependencies = {
--   --   'nvim-treesitter/nvim-treesitter-textobjects',
--   -- },
--   -- event = { 'BufNewFile', 'BufReadPost' },
--   -- cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
--   lazy = false,
--   ---@type TSConfig
--   opts = {
--     auto_install = true,
--     highlight = {
--       enable = true,
--       disable = { 'help', 'markdown', 'plantuml', 'vimdoc' },
--     },
--     indent = { enable = true, disable = {} },
--     spell = {
--       enable = true,
--       disable = { 'markdown' },
--     },
--     ensure_installed = {
--       'css',
--       'dockerfile',
--       'html',
--       'javascript',
--       'javascriptreact',
--       'json',
--       'lua',
--       'markdown',
--       'markdown_inline',
--       'python',
--       'query',
--       'scss',
--       'svelte',
--       'toml',
--       'tsx',
--       'typescript',
--       'typescriptreact',
--       'vim',
--       'yaml',
--     },
--     incremental_selection = {
--       enable = true,
--       keymaps = {
--         init_selection = '<BS>',
--         node_incremental = '<BS>',
--         scope_incremental = false,
--         node_decremental = '<S-BS>',
--       },
--     },
--     textobjects = {
--       select = {
--         enable = true,
--         lookahead = true,
--         keymaps = {
--           ['ad'] = '@conditional.outer',
--           ['id'] = '@conditional.inner',
--           ['af'] = '@function.outer',
--           ['if'] = '@function.inner',
--           ['ac'] = '@class.outer',
--           ['ic'] = '@class.inner',
--           ['ab'] = '@block.outer',
--           ['ib'] = '@block.inner',
--         },
--         selection_modes = {
--           ['@conditional.outer'] = 'V',
--           ['@function.outer'] = 'V',
--           ['@class.outer'] = 'V',
--           ['@block.outer'] = 'V',
--         },
--       },
--       move = {
--         enable = true,
--         goto_next = {
--           [']d'] = '@conditional.outer',
--         },
--         goto_previous = {
--           ['[d'] = '@conditional.outer',
--         },
--         goto_next_start = {
--           [']a'] = '@parameter.inner',
--           [']f'] = '@function.outer',
--           [']c'] = '@class.outer',
--         },
--         goto_next_end = {
--           [']A'] = '@parameter.inner',
--           [']F'] = '@function.outer',
--           [']C'] = '@class.outer',
--         },
--         goto_previous_start = {
--           ['[a'] = '@parameter.inner',
--           ['[f'] = '@function.outer',
--           ['[c'] = '@class.outer',
--         },
--         goto_previous_end = {
--           ['[A'] = '@parameter.inner',
--           ['[F'] = '@function.outer',
--           ['[C'] = '@class.outer',
--         },
--       },
--     },
--   },
--   config = function(_, opts)
--     local ok, configs = pcall(require, 'nvim-treesitter.configs')
--     if not ok then
--       vim.notify('nvim-treesitter.configs not found', vim.log.levels.ERROR)
--       return
--     end
--     configs.setup(opts)
--   end,
-- }
