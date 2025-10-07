---@type LazyPluginSpec
local HighlightColors = {
  -- https://github.com/brenoprata10/nvim-highlight-colors
  'brenoprata10/nvim-highlight-colors',
  enabled = false,
  opts = {
    render = 'background', -- or 'foreground' or 'first_column'
    enable_var_usage = true,
    enable_named_colors = true,
    enable_tailwind = true,
  },
}

return HighlightColors
