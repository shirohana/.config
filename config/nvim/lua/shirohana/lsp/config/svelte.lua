---@type vim.lsp.Config
return {
  cmd = { 'svelteserver', '--stdio' },
  filetypes = { 'svelte' },
  root_markers = { 'pnpm-lock.yaml', 'package-lock.json', 'yarn.lock', '.git' },
  on_attach = function(client, bufnr)
    -- See https://github.com/sveltejs/language-tools/issues/2008
    vim.api.nvim_create_autocmd('BufWritePost', {
      group = vim.api.nvim_create_augroup('lspconfig.svelte', { clear = true }),
      pattern = { '*.js', '*.ts' },
      callback = function(ctx)
        client:notify('$/onDidChangeTsOrJsFile', { uri = ctx.match })
      end,
    })

    vim.api.nvim_buf_create_user_command(bufnr, 'LspMigrateToSvelte5', function()
      client:exec_cmd {
        title = 'Migrate Component to Svelte 5 Syntax',
        command = 'migrate_to_svelte_5',
        arguments = { vim.uri_from_bufnr(bufnr) },
      }
    end, { desc = 'Migrate Component to Svelte 5 Syntax' })
  end,
}
