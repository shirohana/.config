---@type LazyPluginSpec
local UltiSnips = {
  -- https://github.com/SirVer/ultisnips
  'SirVer/ultisnips',
  init = function()
    vim.g.UltiSnipsSnippetDirectories = { 'UltiSnips' }
    vim.g.UltiSnipsEnableSnipMate = 0
  end,
}

return UltiSnips
