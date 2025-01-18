---@type LazyPluginSpec
local Flog = {
  -- https://github.com/rbong/vim-flog
  'rbong/vim-flog',
  lazy = true,
  cmd = 'Flog',
  dependencies = {
    'tpope/vim-fugitive',
  },
  init = function()
    vim.g.flog_permanent_default_opts = {
      date = 'short',
    }
  end,
}

return Flog
