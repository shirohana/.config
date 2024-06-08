---@type LazyPluginSpec
local AutoPairs = {
  -- https://github.com/jiangmiao/auto-pairs
  'jiangmiao/auto-pairs',
  init = function()
    local g = vim.g
    g.AutoPairsCenterLine = 0
    g.AutoPairsFlyMode = 1
    g.AutoPairsMapBS = 1
    g.AutoPairsMapCR = 1
    g.AutoPairsMapCh = 0
    g.AutoPairsMapSpace = 1
    g.AutoPairsMultilineClose = 1
    g.AutoPairsShortcutBackInsert = '<M-b>'
    g.AutoPairsShortcutFastWrap = ''
    g.AutoPairsShortcutJump = ''
    g.AutoPairsShortcutToggle = ''
  end,
}

return AutoPairs
