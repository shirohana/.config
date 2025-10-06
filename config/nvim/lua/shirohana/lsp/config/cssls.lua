---@type vim.lsp.ClientConfig
return {
  cmd = { 'vscode-css-language-server', '--stdio' },
  filetypes = { 'css', 'scss' },
  root_markers = { 'package.json', '.git' },
  init_options = {
    provideFormatter = true,
  },
}
