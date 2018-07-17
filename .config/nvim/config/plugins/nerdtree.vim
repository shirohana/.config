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
" Ignore Node.js related files
let g:NERDTreeIgnore += [
      \ '^node_modules$[[dir]]',
      \ '^yarn\.lock$',
      \ '^package-lock\.json$',
      \ '^coverage$[[dir]]',
      \ '^\.nyc_output[[dir]]$',
      \ '^\.changelog$[[dir]]',
      \ '^\.nuxt$[[dir]]',
      \ ]
" Ignore VCS files
let g:NERDTreeIgnore += [
      \ '^\.git$[[dir]]',
      \ ]

autocmd MyAutoCmd StdinReadPre * let s:std_in = 1
autocmd MyAutoCmd VimEnter *
      \ if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") |
      \   bw # | exe 'NERDTree' argv()[0] |
      \ endif
