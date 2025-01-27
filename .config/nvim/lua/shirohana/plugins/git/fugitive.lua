---@type LazyPluginSpec
local Fugitive = {
  -- https://github.com/tpope/vim-fugitive
  'tpope/vim-fugitive',
  cmd = { 'Git', 'Gclog' },
  keys = {
    { '©', '<Cmd>Git<CR>' },
    { '<A-g>', '<Cmd>Git<CR>' },
    { 'gb', '<Cmd>Git blame<CR>' },
  },
}

return Fugitive
