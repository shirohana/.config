local typescript = require 'shirohana.lsp.typescript'

---TypeScript 7's native server, spoken by the project's own `tsc` binary.
---There is no Mason package and no global install: the binary is always the
---project-local one, so the server version always matches the project version.
---@type vim.lsp.ClientConfig
return {
  cmd = function(dispatchers, config)
    return vim.lsp.rpc.start({ config.root_dir .. '/node_modules/.bin/tsc', '--lsp', '--stdio' }, dispatchers)
  end,
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
  },
  -- Activate only on TypeScript 7 projects. The root is the directory owning
  -- `node_modules`, which keeps `cmd` able to find the binary from `root_dir`.
  root_dir = function(bufnr, on_dir)
    local ts = typescript.resolve(bufnr)

    if ts and ts.major >= 7 then
      on_dir(ts.dir)
    end
  end,
}
