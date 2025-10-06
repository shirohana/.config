---@type vim.lsp.ClientConfig
return {
  cmd = { 'bash-language-server', 'start' },
  filetypes = { 'sh', 'bash', 'zsh' },
  root_markers = { '.git', vim.uv.cwd() },
  settings = {
    bashIde = {
      globPattern = vim.env.GLOB_PATTERN or '*@(.sh|.inc|.bash|.command)',
    },
  },
}
