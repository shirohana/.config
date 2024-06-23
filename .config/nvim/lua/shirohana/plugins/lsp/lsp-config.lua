local servers = {
  docker_compose_language_service = {},
  dockerls = {},
  jsonls = {},
  lua_ls = {},
  pyright = {},
  svelte = {},
  tailwindcss = {},
  tsserver = {},
  -- volar = {},
}

---@type LazyPluginSpec
local LspConfig = {
  -- https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',

  event = { 'BufReadPre', 'BufNewFile' },

  dependencies = {
    'SmiteshP/nvim-navic',
    'hrsh7th/cmp-nvim-lsp',
    'mrshmllow/document-color.nvim',
    'onsails/lspkind-nvim',
    'tami5/lspsaga.nvim',
  },

  opts = {
    capabilities = {
      textDocument = {
        colorProvider = {
          dynamicRegistration = true,
        },
        completion = {
          completionItem = {
            snippetSupport = true,
          },
        },
      },
    },
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = '●',
      },
      severity_sort = true,
    },
    servers = servers,
    setups = {
      ['svelte'] = function(name, opts)
        opts.on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd('BufWritePost', {
            group = vim.api.nvim_create_augroup('svelte_ondidchangetsorjsfile', { clear = true }),
            pattern = { '*.js', '*.ts' },
            callback = function(ctx)
              client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
            end,
          })
          opts.on_attach(client, bufnr)
        end
        require('lspconfig')[name].setup(opts)
      end,
    },
  },

  init = function()
    vim.lsp.set_log_level 'warn'
    vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics,
      { underline = true, virtual_text = { spacing = 4, prefix = '' } }
    )
  end,

  config = function(_, opts)
    local Icons = require('shirohana.core.constants').Icons

    local icon_pairs = {
      DiagnosticSignInfo = Icons.Info,
      DiagnosticSignHint = Icons.Hint,
      DiagnosticSignWarn = Icons.Warning,
      DiagnosticSignError = Icons.Error,
      LspSagaLightBulb = Icons.Action,
    }

    for hl_group, icon in pairs(icon_pairs) do
      vim.fn.sign_define(hl_group, { text = icon, texthl = hl_group })
    end

    local capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      require('cmp_nvim_lsp').default_capabilities(),
      opts.capabilities or {}
    )

    local on_attach = function(client, bufnr)
      if client.server_capabilities.colorProvider then
        require('document-color').buf_attach(bufnr)
      end
      if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
        vim.opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
      end
      -- Enable completion triggered by <c-x><c-o>
      vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'
    end

    local function server_setup(server_name)
      local server_opts = vim.tbl_deep_extend('force', {
        capabilities = capabilities,
        on_attach = on_attach,
      }, opts.servers[server_name] or {})
      if opts.setups[server_name] and opts.setups[server_name](server_name, server_opts) then
        return
      end
      if opts.setups['*'] and opts.setups['*'](server_name, server_opts) then
        return
      end
      require('lspconfig')[server_name].setup(server_opts)
    end

    for server_name, server_opts in pairs(opts.servers) do
      if not server_opts or not server_opts.mason then
        server_setup(server_name)
      end
    end

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('HanaLspAttach', { clear = true }),
      callback = function(event)
        local Keys = require('shirohana.core.constants').Keys
        local function bkeymap(mode, lhs, rhs, km_opts)
          km_opts = km_opts or {}
          km_opts.buffer = event.buf
          vim.keymap.set(mode, lhs, rhs, km_opts)
        end
        if not require('shirohana.config').USE_LSP_SAGA_KEYMAPS then
          bkeymap('n', 'd<Space>', vim.lsp.buf.hover)
          bkeymap('n', 'zj', vim.diagnostic.goto_next)
          bkeymap('n', 'zk', vim.diagnostic.goto_prev)
          bkeymap('n', 'zi', vim.lsp.buf.code_action)
          bkeymap('n', 'zo', vim.diagnostic.open_float)
          bkeymap('n', Keys['<M-r>'], vim.lsp.buf.rename)
        end
        bkeymap('i', '<C-k>', vim.lsp.buf.signature_help)
        bkeymap('n', 'gt', vim.lsp.buf.type_definition)
        bkeymap('n', 'gD', vim.lsp.buf.declaration)
        bkeymap('n', 'gd', vim.lsp.buf.definition)
        bkeymap('n', 'gu', vim.lsp.buf.references)
        bkeymap('n', 'gi', vim.lsp.buf.implementation)
        bkeymap('n', 'z<Space>', vim.diagnostic.setloclist)
        bkeymap('n', '<space>f', vim.lsp.buf.format)
        -- bkeymap('n', 'gF', '<Cmd>Lspsaga lsp_finder<CR>')
        -- bkeymap('n', '<Nop>', vim.lsp.buf.add_workspace_folder)
        -- bkeymap('n', '<Nop>', vim.lsp.buf.remove_workspace_folder)
        -- bkeymap('n', '<Nop>', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
      end,
    })
  end,
}

servers.jsonls = {
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { 'package.json' },
          url = 'https://json.schemastore.org/package.json',
        },
        {
          fileMatch = { 'tsconfig*.json' },
          url = 'https://json.schemastore.org/tsconfig.json',
        },
        {
          fileMatch = { '.prettierrc', '.prettierrc.json', 'prettier.config.json' },
          url = 'https://json.schemastore.org/prettierrc.json',
        },
        {
          fileMatch = { '.eslintrc', '.eslintrc.json' },
          url = 'https://json.schemastore.org/eslintrc.json',
        },
        {
          fileMatch = { '.babelrc', '.babelrc.json', 'babel.config.json' },
          url = 'https://json.schemastore.org/babelrc.json',
        },
        {
          fileMatch = { 'lerna.json' },
          url = 'https://json.schemastore.org/lerna.json',
        },
        {
          fileMatch = { 'now.json', 'vercel.json' },
          url = 'https://json.schemastore.org/now.json',
        },
        {
          fileMatch = { 'jest.config.js' },
          url = 'https://json.schemastore.org/jest.config.json',
        },
      },
    },
  },
}

servers.lua_ls = {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

servers.pyright = {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
}

servers.tsserver = {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    -- 'typescript.tsx',
    'javascript',
    'typescript',
    'typescriptreact',
    'vue',
  },
  -- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#vue-support
  init_options = {
    plugins = {
      {
        name = '@vue/typescript-plugin',
        location = '/Users/shirohana/Library/pnpm/global/5/node_modules/@vue/typescript-plugin',
        languages = { 'javascript', 'typescript', 'vue' },
      },
    },
  },
}

---@todo Currently Hana is not deving in Vue, and this is not tested
-- servers.volar = {
--   -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#volar
--   -- Take Over Mode
--   -- Volar (prior to 2.0.0), can serve as a language server for both Vue and TypeScript via Take Over Mode.
--   -- To enable Take Over Mode, override the default filetypes in setup{} as follows:
--   filetypes = {
--     'typescript',
--     'javascript',
--     'javascriptreact',
--     'typescriptreact',
--     'vue',
--     'json',
--   },
--   -- Overriding the default TypeScript Server used by Volar
--   -- The default config looks for TS in the local node_modules. This can lead to issues e.g. when working on a monorepo.
--   on_new_config = function(new_config, new_root_dir)
--     local util = require 'lspconfig.util'
--     local function get_typescript_server_path(root_dir)
--       local global_ts = '/Users/shirohana/Library/pnpm/global/5/node_modules/typescript/lib'
--       local found_ts = ''
--       local function check_dir(path)
--         found_ts = util.path.join(path, 'node_modules', 'typescript', 'lib')
--         if util.path.exists(found_ts) then
--           return path
--         end
--       end
--       if util.search_ancestors(root_dir, check_dir) then
--         return found_ts
--       else
--         return global_ts
--       end
--     end
--     new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
--   end,
-- }

return LspConfig
