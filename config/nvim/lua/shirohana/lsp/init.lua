local Icons = require('shirohana.core.constants').Icons

vim.diagnostic.config {
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  virtual_text = { spacing = 4, source = 'if_many', prefix = '●' },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = Icons.Error,
      [vim.diagnostic.severity.WARN] = Icons.Warning,
      [vim.diagnostic.severity.INFO] = Icons.Info,
      [vim.diagnostic.severity.HINT] = Icons.Hint,
    },
  },
}

vim.lsp.config('*', {
  capabilities = require 'shirohana.lsp.capabilities',
  on_attach = require 'shirohana.lsp.on_attach',
})

-- require('shirohana.lsp.workspace-diagnostics').setup {
--   auto_populate = { 'ts_ls' },
-- }

local completion_kinds = vim.lsp.protocol.CompletionItemKind
for i, kind in ipairs(completion_kinds) do
  completion_kinds[i] = Icons[kind] and Icons[kind] .. kind or kind
end

local config_path = vim.fn.stdpath 'config' .. '/lua/shirohana/lsp/config'
local lsp_configs = {}

for name, type in vim.fs.dir(config_path) do
  if type == 'file' and name:match '%.lua$' then
    local lsp_name = name:gsub('%.lua$', '')
    vim.lsp.config[lsp_name] = require('shirohana.lsp.config.' .. lsp_name)
    table.insert(lsp_configs, lsp_name)
  end
end

vim.lsp.enable(lsp_configs)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf

    local function bkeymap(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    local function toggle_virtual_lines()
      local current_config = vim.diagnostic.config().virtual_lines
      vim.diagnostic.config { virtual_lines = not current_config }
    end

    bkeymap(
      'n',
      '<Space>v',
      toggle_virtual_lines,
      { desc = 'Toggle diagnostic virtual lines manually' }
    )

    bkeymap('n', 'd<Space>', vim.lsp.buf.hover)
    bkeymap('n', 'zj', function()
      vim.diagnostic.jump { count = 1, float = true }
    end)
    bkeymap('n', 'zk', function()
      vim.diagnostic.jump { count = -1, float = true }
    end)
    bkeymap('n', 'zi', vim.lsp.buf.code_action)
    bkeymap('n', 'zo', vim.diagnostic.open_float)
    bkeymap('n', '<Space>r', vim.lsp.buf.rename)

    -- bkeymap('n', 'gt', vim.lsp.buf.type_definition)
    -- bkeymap('n', 'gD', vim.lsp.buf.declaration)
    -- bkeymap('n', 'gd', vim.lsp.buf.definition)

    bkeymap('n', 'gu', vim.lsp.buf.references)
    bkeymap('n', 'gi', vim.lsp.buf.implementation)
    bkeymap('n', 'z<Space>', vim.diagnostic.setloclist)
    bkeymap('n', '<Space>f', vim.lsp.buf.format)
    bkeymap('i', '<C-k>', vim.lsp.buf.signature_help)
    -- bkeymap('n', '<Space>D', function()
    --   require('shirohana.lsp.workspace-diagnostics').populate_all_workspace_diagnostics()
    -- end, { desc = 'Populate workspace diagnostics' })

    -- bkeymap('n', '<Nop>', vim.lsp.buf.add_workspace_folder)
    -- bkeymap('n', '<Nop>', vim.lsp.buf.remove_workspace_folder)
    -- bkeymap('n', '<Nop>', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>')
  end,
})

-- Disable the default keybinds {{{
-- for _, bind in ipairs { 'grn', 'gra', 'gri', 'grr' } do
--   pcall(vim.keymap.del, 'n', bind)
-- end
-- }}}

-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(ev)
--     local bufnr = ev.buf
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     if not client then
--       return
--     end
--     ---@diagnostic disable-next-line need-check-nil
--     if client.server_capabilities.completionProvider then
--       vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
--       -- vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"
--     end
--     ---@diagnostic disable-next-line need-check-nil
--     if client.server_capabilities.definitionProvider then
--       vim.bo[bufnr].tagfunc = 'v:lua.vim.lsp.tagfunc'
--     end
--
--     -- -- nightly has inbuilt completions, this can replace all completion plugins
--     -- if client:supports_method("textDocument/completion", bufnr) then
--     --   -- Enable auto-completion
--     --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
--     -- end
--
--     --- Disable semantic tokens
--     ---@diagnostic disable-next-line need-check-nil
--     client.server_capabilities.semanticTokensProvider = nil
--
--     -- All the keymaps
--     -- stylua: ignore start
--     local keymap = vim.keymap.set
--     local lsp = vim.lsp
--     local opts = { silent = true }
--     local function opt(desc, others)
--       return vim.tbl_extend("force", opts, { desc = desc }, others or {})
--     end
--     keymap("n", "gd", lsp.buf.definition, opt("Go to definition"))
--     keymap("n", "gD", function()
--       local ok, diag = pcall(require, "rj.extras.definition")
--       if ok then
--         diag.get_def()
--       end
--     end, opt("Get the definition in a float"))
--     keymap("n", "gi", function() lsp.buf.implementation({ border = "single" }) end, opt("Go to implementation"))
--     keymap("n", "gr", lsp.buf.references, opt("Show References"))
--     keymap("n", "gl", vim.diagnostic.open_float, opt("Open diagnostic in float"))
--     keymap("n", "<C-k>", lsp.buf.signature_help, opts)
--     -- disable the default binding first before using a custom one
--     pcall(vim.keymap.del, "n", "K", { buffer = ev.buf })
--     keymap("n", "K", function() lsp.buf.hover({ border = "single", max_height = 30, max_width = 120 }) end,
--       opt("Toggle hover"))
--     keymap("n", "<Leader>lF", vim.cmd.FormatToggle, opt("Toggle AutoFormat"))
--     keymap("n", "<Leader>lI", vim.cmd.Mason, opt("Mason"))
--     keymap("n", "<Leader>lS", lsp.buf.workspace_symbol, opt("Workspace Symbols"))
--     keymap("n", "<Leader>la", lsp.buf.code_action, opt("Code Action"))
--     keymap("n", "<Leader>lh", function() lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled({})) end,
--       opt("Toggle Inlayhints"))
--     keymap("n", "<Leader>li", vim.cmd.LspInfo, opt("LspInfo"))
--     keymap("n", "<Leader>ll", lsp.codelens.run, opt("Run CodeLens"))
--     keymap("n", "<Leader>lr", lsp.buf.rename, opt("Rename"))
--     keymap("n", "<Leader>ls", lsp.buf.document_symbol, opt("Doument Symbols"))
--
--     -- diagnostic mappings
--     keymap("n", "<Leader>dD", function()
--       local ok, diag = pcall(require, "rj.extras.workspace-diagnostic")
--       if ok then
--         for _, cur_client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
--           diag.populate_workspace_diagnostics(cur_client, 0)
--         end
--         vim.notify("INFO: Diagnostic populated")
--       end
--     end, opt("Popluate diagnostic for the whole workspace"))
--     keymap("n", "<Leader>dn", function() vim.diagnostic.jump({ count = 1, float = true }) end, opt("Next Diagnostic"))
--     keymap("n", "<Leader>dp", function() vim.diagnostic.jump({ count = -1, float = true }) end, opt("Prev Diagnostic"))
--     keymap("n", "<Leader>dq", vim.diagnostic.setloclist, opt("Set LocList"))
--     keymap("n", "<Leader>dv", function()
--       vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
--     end, opt("Toggle diagnostic virtual_lines"))
--     -- stylua: ignore end
--   end,
-- })

-- vim.api.nvim_create_user_command('LspStart', function()
--   vim.cmd.e()
-- end, { desc = 'Starts LSP clients in the current buffer' })

-- vim.api.nvim_create_user_command('LspStop', function(opts)
--   for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
--     if opts.args == '' or opts.args == client.name then
--       client:stop(true)
--       vim.notify(client.name .. ': stopped')
--     end
--   end
-- end, {
--   desc = 'Stop all LSP clients or a specific client attached to the current buffer.',
--   nargs = '?',
--   complete = function(_, _, _)
--     local clients = vim.lsp.get_clients { bufnr = 0 }
--     local client_names = {}
--     for _, client in ipairs(clients) do
--       table.insert(client_names, client.name)
--     end
--     return client_names
--   end,
-- })

-- vim.api.nvim_create_user_command('LspRestart', function()
--   local detach_clients = {}
--   for _, client in ipairs(vim.lsp.get_clients { bufnr = 0 }) do
--     client:stop(true)
--     if vim.tbl_count(client.attached_buffers) > 0 then
--       detach_clients[client.name] = { client, vim.lsp.get_buffers_by_client_id(client.id) }
--     end
--   end
--   local timer = vim.uv.new_timer()
--   if not timer then
--     return vim.notify 'Servers are stopped but havent been restarted'
--   end
--   timer:start(
--     100,
--     50,
--     vim.schedule_wrap(function()
--       for name, client in pairs(detach_clients) do
--         local client_id = vim.lsp.start(client[1].config, { attach = false })
--         if client_id then
--           for _, buf in ipairs(client[2]) do
--             vim.lsp.buf_attach_client(buf, client_id)
--           end
--           vim.notify(name .. ': restarted')
--         end
--         detach_clients[name] = nil
--       end
--       if next(detach_clients) == nil and not timer:is_closing() then
--         timer:close()
--       end
--     end)
--   )
-- end, { desc = 'Restart all the language client(s) attached to the current buffer' })

-- vim.api.nvim_create_user_command('LspLog', function()
--   vim.cmd.split(vim.lsp.log.get_filename())
-- end, { desc = 'Get all the lsp logs' })

-- vim.api.nvim_create_user_command('LspInfo', function()
--   vim.cmd 'silent checkhealth vim.lsp'
-- end, { desc = 'Get all the information about all LSP attached' })
