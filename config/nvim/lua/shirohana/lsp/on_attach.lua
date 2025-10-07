local on_attach = function(client, bufnr)
  -- todo merge all server on_attach

  -- local ok, diag = pcall(require, "shirohana.lsp.workspace-diagnostics")
  -- if ok then
  --   diag.populate_workspace_diagnostics(client, bufnr)
  -- end

  -- print('attach', vim.inspect(client.server_capabilities))
  -- if client.server_capabilities.colorProvider then
  --   require('document-color').buf_attach(bufnr)
  -- end
  require('colorizer').attach_to_buffer(bufnr)

  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, bufnr)
    vim.opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
  end
end

return on_attach
