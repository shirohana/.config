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
local MasonToolInstaller = {
  -- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = {
    ensure_installed = {
      -- docker
      'docker-compose-language-service',
      'dockerfile-language-server',
      'hadolint',
      -- javascript
      'eslint_d',
      'prettierd',
      'svelte-language-server',
      'tailwindcss-language-server',
      'typescript-language-server',
      -- json / yaml
      'json-lsp',
      'yaml-language-server',
      'yamlfmt',
      -- llm
      'copilot-language-server',
      -- lua
      'lua-language-server',
      'stylua',
      -- python
      'black',
      'pylint',
      'pyright',
      -- shell
      'bash-language-server',
      'shellcheck',
      'shfmt',
    },
  },
}

return { Mason, MasonToolInstaller }
