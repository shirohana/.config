---@type LazyPluginSpec
local EasyAlign = {
  -- https://github.com/junegunn/vim-easy-align
  'junegunn/vim-easy-align',
  event = 'BufEnter',
  keys = {
    { 'ga', '<Plug>(EasyAlign)' },
    { 'ga', '<Plug>(LiveEasyAlign)', mode = 'v' },
  },
}

return EasyAlign
