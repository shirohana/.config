---@type LazyPluginSpec
local BetterWhitespace = {
  -- https://github.com/ntpeters/vim-better-whitespace
  'ntpeters/vim-better-whitespace',
  event = 'BufEnter',
  init = function()
    local g = vim.g
    g.better_whitespace_operator = 0
    g.show_spaces_that_precede_tabs = 1
    g.strip_whitespace_confirm = 0
    vim.cmd [[
    augroup HanaBetterWhitespace
      autocmd!
      autocmd BufEnter * EnableStripWhitespaceOnSave
    augroup END
    ]]
  end,
}

return BetterWhitespace
