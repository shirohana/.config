---@type LazyPluginSpec
local Undotree = {
  -- https://github.com/mbbill/undotree
  'mbbill/undotree',
  cmd = 'UndotreeToggle',
  keys = {
    { 'U', '<Cmd>UndotreeToggle<Bar>wincmd p<CR>', { desc = 'Toggle Undotree' }},
  },
  init = function()
    vim.g.undotree_WindowLayout = 4
    if vim.fn.has 'persistent_undo' then
      vim.opt.undofile = true
    end
  end,
}

return Undotree
