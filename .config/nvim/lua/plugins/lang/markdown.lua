local Plugins = require('vars').Plugins

---@type LazyPluginSpec
local MarkdownPreview = {
  Plugins.MarkdownPreview,
  ft = 'markdown',
  dependencies = { Plugins.OpenBrowser },
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

return { MarkdownPreview }
