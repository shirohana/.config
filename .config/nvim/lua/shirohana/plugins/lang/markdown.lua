---@type LazyPluginSpec
local MarkdownPreview = {
  -- https://github.com/JamshedVesuna/vim-markdown-preview
  'JamshedVesuna/vim-markdown-preview',
  ft = 'markdown',
  dependencies = {
    'tyru/open-browser.vim',
  },
  init = function()
    vim.g.vim_markdown_preview_toggle = -1
    vim.g.vim_markdown_preview_github = 1
    vim.g.vim_markdown_preview_browser = 'Safari'
    vim.cmd [[
    augroup HanaMarkdownPreview
      autocmd!
      autocmd FileType markdown nnoremap <buffer> <silent> <CR> :<C-u>call Vim_Markdown_Preview_Local()<CR>
    augroup END
    ]]
  end,
}

return MarkdownPreview
