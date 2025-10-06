local Keys = require('shirohana.core.constants').Keys

---@type LazyPluginSpec
local Fugitive = {
  -- https://github.com/tpope/vim-fugitive
  'tpope/vim-fugitive',
  cmd = { 'Git', 'Gclog' },
  keys = {
    { 'gb', '<Cmd>Git blame<CR>' },
  },
}

return Fugitive
