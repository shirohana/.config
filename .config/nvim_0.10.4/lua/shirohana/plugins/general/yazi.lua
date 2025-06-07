---@type LazyPluginSpec
local Yazi = {
  -- https://github.com/mikavilpas/yazi.nvim
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  keys = {
    { '<leader>P', '<Cmd>Yazi<CR>', desc = 'Open Yazi at the current file' },
    { '<leader>p', '<Cmd>Yazi cwd<CR>', desc = 'Open Yazi in working directory' },
  },
  opts = {},
}

return Yazi
