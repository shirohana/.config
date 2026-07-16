---@type LazyPluginSpec
local Kulala = {
  -- https://github.com/mistweaverco/kulala.nvim
  'mistweaverco/kulala.nvim',
  ft = { 'http', 'rest' },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = '<Leader>u',
    kulala_keymaps_prefix = '',
  },
}

return Kulala
