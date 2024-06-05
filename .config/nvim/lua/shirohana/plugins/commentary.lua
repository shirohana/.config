---@type LazyPluginSpec
local Commentary = {
  -- https://github.com/tpope/vim-commentary
  'tpope/vim-commentary',
  event = 'BufEnter',
  keys = {
    { 'gc', '<Plug>Commentary', mode = { 'n', 'o', 'v' } },
    { 'gcc', '<Plug>CommentaryLine' },
    { 'cgc', '<Plug>ChangeCommentary' },
    { 'gcu', '<Plug>Commentary<Plug>Commentary' },
  },
  init = function()
    vim.g.commentary_line_mapping = '<C-_>'
    vim.g.commentary_motion_mapping = '<C-_>'
    vim.g.commentary_nesting = 1
    vim.g.commentary_use_keymap = 0
    vim.cmd [[
    augroup HanaEnvCommentary
      autocmd!
      autocmd FileType dart setlocal commentstring=//\ %s
    augroup END
    ]]
  end,
}

return Commentary
