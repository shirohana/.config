---@diagnostic disable: redefined-local

local sources = { vim.lsp.protocol.make_client_capabilities() }

local ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if ok then
  table.insert(sources, cmp_nvim_lsp.default_capabilities())
end

local ok, lsp_file_operations = pcall(require, 'lsp-file-operations')
if ok then
  table.insert(sources, lsp_file_operations.default_capabilities())
end

table.insert(sources, {
  textDocument = {
    colorProvider = {
      dynamicRegistration = true,
    },
  },
})

local capabilities = vim.tbl_deep_extend('force', unpack(sources))

return capabilities
