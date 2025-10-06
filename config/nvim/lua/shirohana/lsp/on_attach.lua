local on_attach = function(client, bufnr)
  -- todo merge all server on_attach

  -- local ok, diag = pcall(require, "shirohana.lsp.workspace-diagnostics")
  -- if ok then
  --   diag.populate_workspace_diagnostics(client, bufnr)
  -- end
end

return on_attach
