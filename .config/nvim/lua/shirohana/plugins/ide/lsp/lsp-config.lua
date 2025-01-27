local servers = {
  bashls = {},
  docker_compose_language_service = {},
  dockerls = {},
  eslint = {},
  jsonls = {},
  lua_ls = {},
  pyright = {},
  svelte = {},
  tailwindcss = {},
  ts_ls = {},
  yamlls = {},
}

local setups = {
  svelte = nil,
}

for name, server_opts in pairs(servers) do
  local ok, server_config = pcall(require, 'shirohana.plugins.ide.lsp.server.' .. name)
  if ok then
    vim.tbl_deep_extend('force', server_config, server_opts)
  end
end

-- for name in pairs(setups) do
--   local ok, setup_config = pcall(require, 'shirohana.plugins.ide.lsp.server.' .. name .. '.setup')
--   if ok then
--     setups[name] = setup_config
--   end
-- end
--
---@type LazyPluginSpec
local LspConfig = {
  -- https://github.com/neovim/nvim-lspconfig
  'neovim/nvim-lspconfig',

  event = { 'BufReadPre', 'BufNewFile' },

  dependencies = {
    'SmiteshP/nvim-navic',
    'hrsh7th/cmp-nvim-lsp',
    -- 'onsails/lspkind-nvim',
    -- 'tami5/lspsaga.nvim',
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
    setups = setups,
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
      require('lsp-file-operations').default_capabilities(),
      opts.capabilities or {}
    )

    local on_attach = function(client, bufnr)
      -- if client.server_capabilities.colorProvider then
      --   require('document-color').buf_attach(bufnr)
      -- end
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

return LspConfig
