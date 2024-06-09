---@type LazyPluginSpec
local NoneLs = {
  -- https://github.com/nvimtools/none-ls.nvim
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local nls = require 'null-ls'
    local formatter = nls.builtins.formatting
    local action = nls.builtins.code_actions
    local diag = nls.builtins.diagnostics
    nls.setup {
      sources = {
        -- action.eslint_d,
        -- diag.eslint_d.with { diagnostics_format = '[eslint] #{m}\n(#{c})' },
        diag.hadolint,
        formatter.blackd,
        formatter.prettierd,
        formatter.stylua,
      },
    }
  end,
}

return NoneLs
