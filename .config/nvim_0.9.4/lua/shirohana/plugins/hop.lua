---@type LazyPluginSpec
local Hop = {
  -- https://github.com/phaazon/hop.nvim
  'phaazon/hop.nvim',
  commit = 'caaccee',
  event = 'BufEnter',
  config = true,
  keys = {
    { '<LocalLeader>j', '<Cmd>HopLineAC<CR>', { mode = '' } },
    { '<LocalLeader>k', '<Cmd>HopLineBC<CR>', { mode = '' } },
    { '<LocalLeader>w', '<Cmd>HopWordAC<CR>', { mode = '' } },
    { '<LocalLeader>b', '<Cmd>HopWordBC<CR>', { mode = '' } },
  },
}

return Hop
