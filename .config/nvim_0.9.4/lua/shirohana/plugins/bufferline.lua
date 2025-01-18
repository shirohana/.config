---@type LazyPluginSpec
local Bufferline = {
  -- https://github.com/akinsho/bufferline.nvim
  'akinsho/bufferline.nvim',
  enabled = require('shirohana.config').USE_BUFFERLINE,
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
