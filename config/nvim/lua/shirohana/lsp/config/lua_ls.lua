---@type vim.lsp.ClientConfig
return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.git' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      completion = {
        callSnippet = 'Replace',
      },
      telemetry = { enable = false },
    },
  },
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend(
      'force',
      ---@diagnostic disable-next-line: param-type-mismatch
      client.config.settings.Lua,
      { workspace = { library = { vim.env.VIMRUNTIME } } }
    )
  end,
}
