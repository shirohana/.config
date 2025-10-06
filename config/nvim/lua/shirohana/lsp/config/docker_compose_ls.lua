---@type vim.lsp.ClientConfig
return {
  cmd = { 'docker-compose-langserver', '--stdio' },
  filetypes = { 'yaml.docker-compose' },
  root_markers = { 'docker-compose.yml', '.git' },
  single_file_support = true,
}
