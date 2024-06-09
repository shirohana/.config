---@type LazyPluginSpec
local Mason = {
  -- https://github.com/williamboman/mason.nvim
  'williamboman/mason.nvim',
  build = ':MasonUpdate',
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
  },
  opts = {},
}

---@type LazyPluginSpec
-- local MasonLspConfig = {
--   -- https://github.com/williamboman/mason-lspconfig.nvim
--   'williamboman/mason-lspconfig.nvim',
--   dependencies = {
--     'williamboman/mason.nvim',
--   },
--   opts = {
--     ensure_installed = {
--       'docker_compose_language_service',
--       'dockerls',
--       'jsonls',
--       'lua_ls',
--       'pyright',
--       'svelte',
--       'tailwindcss',
--       'tsserver',
--     },
--   },
-- }

---@type LazyPluginSpec
local MasonToolInstaller = {
  -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = {
    ensure_installed = {
      'black',
      'eslint_d',
      'lua-language-server',
      'prettierd',
      'pylint',
      'pyright',
      'shellcheck',
      'stylua',
    },
  },
}

return { Mason, MasonToolInstaller }
