---@type LazyPluginSpec
local NoneLs = {
  -- https://github.com/nvimtools/none-ls.nvim
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- 'nvimtools/none-ls-extras.nvim',
  },
  config = function()
    local nls = require 'null-ls'
    local diag = nls.builtins.diagnostics
    local formatter = nls.builtins.formatting
    nls.setup {
      sources = {
        diag.hadolint,
        -- formatter.blackd,
        formatter.prettierd,
        formatter.stylua,
      },
    }
  end,
}

return NoneLs
