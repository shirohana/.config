-- stylua: ignore
local NavicTheme = {
  NavicIconsField         = { fg = '#B5585F', bg = 'NONE' },
  NavicIconsProperty      = { fg = '#B5585F', bg = 'NONE' },
  NavicIconsEvent         = { fg = '#B5585F', bg = 'NONE' },

  NavicText               = { fg = '#82AAFF', bg = 'NONE' },
  NavicIconsEnum          = { fg = '#C3E88D', bg = 'NONE' },
  NavicIconsKey           = { fg = '#C3E88D', bg = 'NONE' },

  NavicIconsConstant      = { fg = '#FFE082', bg = 'NONE' },
  NavicIconsConstructor   = { fg = '#FFE082', bg = 'NONE' },

  NavicIconsFunction      = { fg = '#A377BF', bg = 'NONE' },
  NavicIconsStruct        = { fg = '#A377BF', bg = 'NONE' },
  NavicIconsClass         = { fg = '#A377BF', bg = 'NONE' },
  NavicIconsModule        = { fg = '#A377BF', bg = 'NONE' },
  NavicIconsOperator      = { fg = '#A377BF', bg = 'NONE' },

  NavicIconsVariable      = { fg = '#7E8294', bg = 'NONE' },
  NavicIconsFile          = { fg = '#7E8294', bg = 'NONE' },

  NavicIconsMethod        = { fg = '#6C8ED4', bg = 'NONE' },
  NavicIconsEnumMember    = { fg = '#6C8ED4', bg = 'NONE' },

  NavicIconsInterface     = { fg = '#58B5A8', bg = 'NONE' },
  NavicIconsTypeParameter = { fg = '#58B5A8', bg = 'NONE' },

  NavicIconsNamespace     = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsPackage       = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsString        = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsNumber        = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsBoolean       = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsArray         = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsObject        = { fg = '#0087ff', bg = 'NONE' },
  NavicIconsNull          = { fg = '#0087ff', bg = 'NONE' },
  NavicSeparator          = { fg = '#004657', bg = 'NONE' },
}

-- local util = require 'lspconfig.util'

local Icons = require('shirohana.variables').Icons

---@type LazyPluginSpec
local DocumentColor = {
  -- https://github.com/mrshmllow/document-color.nvim
  'mrshmllow/document-color.nvim',
  opts = { mode = 'background' },
}

---@type LazyPluginSpec
local Fidget = {
  -- https://github.com/j-hui/fidget.nvim
  'j-hui/fidget.nvim',
  tag = 'legacy',
  opts = { text = { spinner = 'dots' } },
}

---@type LazyPluginSpec
local LspKind = {
  -- https://github.com/onsails/lspkind-nvim
  'onsails/lspkind-nvim',
  opts = { symbol_map = Icons },
  config = function(_, opts)
    require('lspkind').init(opts)
  end,
}

---@type LazyPluginSpec
local LspSaga = {
  -- https://github.com/tami5/lspsaga.nvim
  'tami5/lspsaga.nvim',
  keys = {
    { 'd<Space>', '<Cmd>Lspsaga hover_doc<CR>' },
    { '<Space>d', '<Cmd>Lspsaga preview_definition<CR>' },
    -- Use `lsp-signature` instead
    {
      '<C-k>',
      '<Cmd>Lspsaga signature_help<CR>',
      { mode = { 'n', 'i' } },
    },
    -- keymap('n', 'gu', '<Cmd>Lspsaga lsp_finder<CR>')
    { 'zi', '<Cmd>Lspsaga code_action<CR>' },
    -- { 'zi', '<Cmd>Lspsaga range_code_action<CR>',    { mode = 'x' } },
    { 'zo', '<Cmd>Lspsaga show_line_diagnostics<CR>' },
    { 'zj', '<Cmd>Lspsaga diagnostic_jump_next<CR>' },
    { 'zk', '<Cmd>Lspsaga diagnostic_jump_prev<CR>' },
    -- Rename symbols, using <Opt-r>
    { '<A-r>',  '<Cmd>Lspsaga rename<CR>' },
    { '®',  '<Cmd>Lspsaga rename<CR>' },
    -- { '<Space>k', '<Cmd>Lspsaga signature_help<CR>' },
    -- { '<Space>u', '<Cmd>Lspsaga show_line_diagnostics<CR>' },
    -- { '<Space>o', '<Cmd>Lspsaga diagnostic_jump_next<CR>' },
    -- { '<Space>i', '<Cmd>Lspsaga diagnostic_jump_prev<CR>' },
    -- { '<Space>r', '<Cmd>Lspsaga rename<CR>' },
    -- { '<Space>a', '<Cmd>Lspsaga code_action<CR>' },
    -- { '<Space>f', '<Cmd>Lspsaga lsp_finder<CR>' },
    -- { '<Space>q', '<Cmd>Lspsaga close_floaterm<CR>' },
  },
  opts = {
    border_style = 'round',
    code_action_icon = string.format('%s ', Icons.Action),
    diagnostic_header_icon = string.format(' %s  ', Icons.Bug),
    error_sign = Icons.Error,
    hint_sign = Icons.Hint,
    infor_sign = Icons.Info,
    warn_sign = Icons.Warning,
    -- finder_definition_icon = '  ',
    -- finder_reference_icon = '  ',
  },
}

---@type LazyPluginSpec
local LuaDev = {
  -- https://github.com/folke/neodev.nvim
  'folke/neodev.nvim',
  opts = { experimental = { pathStrict = true } },
}

---@type LazyPluginSpec
local Mason = {
  -- https://github.com/williamboman/mason.nvim
  'williamboman/mason.nvim',
  build = ':MasonUpdate',
  config = true,
  opts = {
    ensure_installed = {
      'hadolint',
    },
  },
}

---@type LazyPluginSpec
local LspConfig = {
  -- https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'mrshmllow/document-color.nvim',
    'onsails/lspkind-nvim',
    'tami5/lspsaga.nvim',
    'folke/neodev.nvim',
    'williamboman/mason.nvim',
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason-lspconfig.nvim',
  },

  -- Copied from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/init.lua
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
    -- diagnostics = {
    --   underline = true,
    --   update_in_insert = false,
    --   virtual_text = {
    --     spacing = 4,
    --     source = 'if_many',
    --     prefix = '●',
    --   },
    --   severity_sort = true,
    -- },
    servers = {
      dartls = {},
      dockerls = {},
      docker_compose_language_service = {},
      jsonls = {
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
                fileMatch = {
                  '.prettierrc',
                  '.prettierrc.json',
                  'prettier.config.json',
                },
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
      },

      lua_ls = {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },

      pyright = {
        cmd = { 'pyright-langserver', '--stdio' },
        filetypes = { 'python' },
      },

      svelte = {},

      tailwindcss = {},

      tsserver = {
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = {
          'javascript',
          'typescript',
          -- 'typescript.tsx',
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
      },

      -- volar = {
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
      --     local function get_typescript_server_path(root_dir)
      --       local global_ts =
      --         '/Users/shirohana/Library/pnpm/global/5/node_modules/typescript/lib'
      --       local found_ts = ''
      --       local function check_dir(path)
      --         found_ts =
      --           util.path.join(path, 'node_modules', 'typescript', 'lib')
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
      --     new_config.init_options.typescript.tsdk =
      --       get_typescript_server_path(new_root_dir)
      --   end,
      -- },
    },
    setups = {},
  },

  init = function()
    vim.lsp.set_log_level 'warn'
    vim.lsp.handlers['textDocument/publishDiagnostics'] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          underline = true,
          virtual_text = {
            spacing = 4,
            prefix = '',
          },
        })
  end,

  config = function(_, opts)
    local on_attach = function(client, bufnr)
      if client.server_capabilities.colorProvider then
        require('document-color').buf_attach(bufnr)
      end

      if client.server_capabilities.documentSymbolProvider then
        require('nvim-navic').attach(client, bufnr)
        vim.opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
      end

      -- when filetype is TypeScript, attach twoslash queries
      if client.name == 'tsserver' then
        require('twoslash-queries').attach(client, bufnr)
      end

      if client.name == 'svelte' then
        vim.api.nvim_create_autocmd('BufWritePost', {
          group = vim.api.nvim_create_augroup(
            'svelte_ondidchangetsorjsfile',
            { clear = true }
          ),
          pattern = { '*.js', '*.ts' },
          callback = function(ctx)
            client.notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
          end,
        })
      end

      local function bkeymap(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
      end

      -- Enable completion triggered by <c-x><c-o>
      vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

      -- bkeymap('n', 'd<Space>', '<Cmd>lua vim.lsp.buf.hover()<CR>')
      -- bkeymap('i', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')
      bkeymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
      bkeymap('n', 'gu', '<Cmd>lua vim.lsp.buf.references()<CR>')
      bkeymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
      bkeymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>')
      -- bkeymap('n', 'zj', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
      -- bkeymap('n', 'zk', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
      bkeymap('n', 'z<Space>', '<Cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
      -- bkeymap('n', '<space>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>')
      -- bkeymap('n', '<space>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>')
      -- bkeymap('n', '<space>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
      -- bkeymap('n', '<space>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>')
      -- bkeymap('n', '®', '<Cmd>lua vim.lsp.buf.rename()<CR>')
      -- bkeymap('n', '<space>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
      -- bkeymap('n', '<space>e', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
      -- bkeymap('n', '<space>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>')
    end

    local capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      require('cmp_nvim_lsp').default_capabilities(),
      opts.capabilities or {}
    )

    local function server_setup(server_name)
      local server_opts = vim.tbl_deep_extend('force', {
        on_attach = on_attach,
        capabilities = capabilities,
      }, opts.servers[server_name] or {})
      if
          opts.setups[server_name]
          and opts.setups[server_name](server_name, server_opts)
      then
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
  end,
}

---@type LazyPluginSpec
local Navic = {
  -- https://github.com/SmiteshP/nvim-navic
  'SmiteshP/nvim-navic',
  dependencies = {
    'neovim/nvim-lspconfig',
  },
  opts = {
    depth_limit = 0,
    depth_limit_indicator = '..',
    highlight = true,
    icons = vim.tbl_map(function(v)
      return string.format('%s ', v)
    end, Icons),
    safe_output = true,
    separator = '  ',
  },
  init = function()
    for name, opts in pairs(NavicTheme) do
      vim.api.nvim_set_hl(0, name, opts)
    end
  end,
}

---@type LazyPluginSpec
-- local LspLines = {
--   Plugins.LspLines,
-- }

---@type LazyPluginSpec
local Trouble = {
  -- https://github.com/folke/trouble.nvim
  'folke/trouble.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
}

return {
  DocumentColor,
  Fidget,
  LspConfig,
  LspKind,
  LspSaga,
  LuaDev,
  Mason,
  Navic,
  Trouble,
}
