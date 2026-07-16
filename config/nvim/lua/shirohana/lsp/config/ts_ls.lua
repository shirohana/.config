local typescript = require 'shirohana.lsp.typescript'

---@type vim.lsp.ClientConfig
return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  -- Yield to `tsgo` on TypeScript 7 projects; serve everything else, including
  -- loose files with no local install (Mason bundles a TypeScript 5 fallback).
  root_dir = function(bufnr, on_dir)
    if typescript.is_native(bufnr) then
      return
    end

    on_dir(vim.fs.root(bufnr, { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' }))
  end,
  init_options = {
    hostInfo = 'neovim',
  },
}
