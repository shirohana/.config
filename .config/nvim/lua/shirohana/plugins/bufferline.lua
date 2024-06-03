---@type LazyPluginSpec
local Bufferline = {
  -- https://github.com/akinsho/bufferline.nvim
  'akinsho/bufferline.nvim',
  ---@todo wip
  enabled = false,
  version = '*',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      mode = 'buffers',
      truncate_names = false,
    },
  },
}

return Bufferline
