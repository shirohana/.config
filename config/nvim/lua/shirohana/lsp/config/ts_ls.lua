---@type vim.lsp.ClientConfig
return {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = {
    'javascript',
    'typescript',
    'typescriptreact',
  },
  root_markers = { 'tsconfig.json', 'jsconfig.json', 'package.json', '.git' },
  init_options = {
    hostInfo = 'neovim',
  },
}
