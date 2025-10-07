---@type LazyPluginSpec
local DocumentColor = {
  -- https://github.com/mrshmllow/document-color.nvim
  'mrshmllow/document-color.nvim',
  event = 'BufEnter',
  opts = { mode = 'background' },
  enabled = false,
  config = function(_, opts)
    require('document-color').setup(opts)
  end,
}

return DocumentColor
