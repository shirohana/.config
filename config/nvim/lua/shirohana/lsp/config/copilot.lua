--- Copied from https://github.com/neovim/nvim-lspconfig/blob/master/lsp/copilot.lua

---@type vim.lsp.ClientConfig
return {
  cmd = {
    'copilot-language-server',
    '--stdio',
  },
  root_markers = { '.git' },
  init_options = {
    editorInfo = {
      name = 'Neovim',
      version = tostring(vim.version()),
    },
    editorPluginInfo = {
      name = 'Neovim',
      version = tostring(vim.version()),
    },
  },
}
