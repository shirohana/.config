---@type LazyPluginSpec
local Fidget = {
  -- https://github.com/j-hui/fidget.nvim
  'j-hui/fidget.nvim',
  tag = 'legacy',
  event = 'BufEnter',
  opts = { text = { spinner = 'dots' } },
}

return Fidget
