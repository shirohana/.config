---@type LazyPluginSpec
local NoneLs = {
  -- https://github.com/nvimtools/none-ls.nvim
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local nls = require 'null-ls'
    local diag = nls.builtins.diagnostics
    local fmt = nls.builtins.formatting
    nls.setup {
      sources = {
        diag.hadolint,
        fmt.prettierd,
        fmt.shfmt,
        fmt.stylua,
        fmt.yamlfmt,
      },
    }
  end,
}

return NoneLs
