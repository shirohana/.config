let g:NERDTreeAutoCenter = 0
let g:NERDTreeCaseSensitiveSort = 1
let g:NERDTreeChDirMode = 0
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeBookmarksFile = expand('$CACHE_DIR/bookmarks')
let g:NERDTreeMinimalUI = 1
let g:NERDTreeCascadeOpenSingleChildDir = 0

" Ignore default pattern
let g:NERDTreeIgnore = ['\~$']
" Ignore system generated files
let g:NERDTreeIgnore += [
      \ '\.swp$',
      \ '^\.DS_Store$',
      \ ]
" Ignore VCS files
let g:NERDTreeIgnore += [
      \ '^\.git$[[dir]]',
      \ ]
" Ignore Node.js related files
let g:NERDTreeIgnore += [
      \ '^\.changelog$[[dir]]',
      \ '^\.docker-sync$[[dir]]',
      \ '^\.expo$[[dir]]',
      \ '^\.node-version$',
      \ '^\.nuxt$[[dir]]',
      \ '^\.nyc_output$[[dir]]',
      \ '^coverage$[[dir]]',
      \ '^dist$[[dir]]',
      \ '^log$[[dir]]',
      \ '^node_modules$[[dir]]',
      \ '^package-lock\.json$',
      \ '^vim-markdown-preview\.html$',
      \ '^yarn\.lock$',
      \ ]

autocmd MyAutoCmd StdinReadPre * let s:std_in = 1
autocmd MyAutoCmd VimEnter *
      \ if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") |
      \   bw # | exe 'NERDTree' argv()[0] |
      \ endif

function! NERDTreeYankCurrentNode()
  let selected = g:NERDTreeFileNode.GetSelected()
  if selected != {}
    call setreg(v:register, selected.path.str())
  endif
endfunction
