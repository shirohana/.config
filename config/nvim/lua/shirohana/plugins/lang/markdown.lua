-- ---@type LazyPluginSpec
-- local MarkdownPreview = {
--   -- https://github.com/JamshedVesuna/vim-markdown-preview
--   'JamshedVesuna/vim-markdown-preview',
--   ft = 'markdown',
--   dependencies = {
--     'tyru/open-browser.vim',
--   },
--   init = function()
--     vim.g.vim_markdown_preview_toggle = -1
--     vim.g.vim_markdown_preview_github = 1
--     vim.g.vim_markdown_preview_browser = 'Safari'
--     vim.cmd [[
--     augroup HanaMarkdownPreview
--       autocmd!
--       autocmd FileType markdown nnoremap <buffer> <silent> <CR> :<C-u>call Vim_Markdown_Preview_Local()<CR>
--     augroup END
--     ]]
--   end,
-- }

---@type LazyPluginSpec
local MarkdownPreview = {
  -- https://github.com/iamcco/markdown-preview.nvim
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  init = function()
    vim.cmd [[
    augroup HanaMarkdownPreview
      autocmd!
      autocmd FileType markdown nnoremap <buffer> <silent> <CR> <Cmd>MarkdownPreview<CR>
    augroup END
    ]]
  end,
}

---@type LazyPluginSpec
local RenderMarkdown = {
  -- https://github.com/MeanderingProgrammer/render-markdown.nvim
  'MeanderingProgrammer/render-markdown.nvim',
  ft = 'markdown',
  opts = {
    file_types = { 'markdown' },
  },
}

return { MarkdownPreview, RenderMarkdown }
