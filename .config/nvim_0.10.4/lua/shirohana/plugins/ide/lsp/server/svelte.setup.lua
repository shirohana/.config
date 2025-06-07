local M = function(name, opts)
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
end

return M
