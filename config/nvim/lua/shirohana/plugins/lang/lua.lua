---@type LazyPluginSpec
local LazyDev = {
  -- https://github.com/folke/lazydev.nvim
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      'lazy.nvim',
    },
  },
}

return LazyDev
