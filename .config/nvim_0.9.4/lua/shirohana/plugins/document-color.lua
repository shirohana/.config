---@type LazyPluginSpec
local DocumentColor = {
  -- https://github.com/mrshmllow/document-color.nvim
  'mrshmllow/document-color.nvim',
  event = 'BufEnter',
  opts = { mode = 'background' },
}

return DocumentColor
