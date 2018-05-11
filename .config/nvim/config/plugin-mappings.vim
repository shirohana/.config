" ======== Airline ======== {{{
if dein#tap('vim-airline')
  " Buffer Navigating, using `Opt+[1-9]`
  if get(g:, 'airline#extensions#tabline#buffer_idx_mode', 0)
    nmap ¡ <Plug>AirlineSelectTab1
    nmap ™ <Plug>AirlineSelectTab2
    nmap £ <Plug>AirlineSelectTab3
    nmap ¢ <Plug>AirlineSelectTab4
    nmap ∞ <Plug>AirlineSelectTab5
    nmap § <Plug>AirlineSelectTab6
    nmap ¶ <Plug>AirlineSelectTab7
    nmap • <Plug>AirlineSelectTab8
    nmap ª <Plug>AirlineSelectTab9
  endif
endif
" }}}

" ======== NERDTree ======== {{{
if dein#tap('nerdtree')
  " Toggle NERDTree, using `Opt-;`
  nmap … :NERDTreeToggle<CR>
endif
" }}}

" ======== EasyMotion ======== {{{
if dein#tap('vim-easymotion')
  map <LocalLeader>j <Plug>(easymotion-sol-j)
  map <LocalLeader>J <Plug>(easymotion-j)
  map <LocalLeader>k <Plug>(easymotion-sol-k)
  map <LocalLeader>K <Plug>(easymotion-k)
  map <LocalLeader>h <Plug>(easymotion-linebackward)
  map <LocalLeader>l <Plug>(easymotion-lineforward)

  map <LocalLeader>w  <Plug>(easymotion-w)
  map <LocalLeader>W  <Plug>(easymotion-W)
  map <LocalLeader>b  <Plug>(easymotion-b)
  map <LocalLeader>B  <Plug>(easymotion-B)
  map <LocalLeader>e  <Plug>(easymotion-e)
  map <LocalLeader>E  <Plug>(easymotion-E)
  map <LocalLeader>ge <Plug>(easymotion-ge)
  map <LocalLeader>gE <Plug>(easymotion-gE)

  map <LocalLeader>n <Plug>(easymotion-n)
  map <LocalLeader>N <Plug>(easymotion-N)

  map ss <Plug>(easymotion-sn)
  map sf <Plug>(easymotion-fl)
  map sF <Plug>(easymotion-Fl)
  map st <Plug>(easymotion-tl)
  map sT <Plug>(easymotion-Tl)
  xmap f <Plug>(easymotion-fl)
  xmap F <Plug>(easymotion-Fl)
  xmap t <Plug>(easymotion-tl)
  xmap T <Plug>(easymotion-Tl)

  if get(g:, 'force_fix_easymotion_cursor', 0)
    omap f <Plug>(easymotion-fl-fix)
    omap F <Plug>(easymotion-Fl-fix)
    omap t <Plug>(easymotion-tl-fix)
    omap T <Plug>(easymotion-Tl-fix)
  else
    omap f <Plug>(easymotion-fl)
    omap F <Plug>(easymotion-Fl)
    omap t <Plug>(easymotion-tl)
    omap T <Plug>(easymotion-Tl)
  endif

  map <LocalLeader><Space> <Plug>(easymotion-repeat)
endif
" }}}

" ======== Incsearch ======== {{{
if dein#tap('incsearch-easymotion.vim')
  map /  <Plug>(incsearch-easymotion-/)
  map ?  <Plug>(incsearch-easymotion-?)
  map g/ <Plug>(incsearch-easymotion-stay)
  map z/ <Plug>(incsearch-fuzzy-/)
  map z? <Plug>(incsearch-fuzzy-?)
  map zg/ <Plug>(incsearch-fuzzy-stay)
endif
" }}}

" ======== Peekaboo ======== {{{
if dein#tap('vim-peekaboo')
  nmap <expr> " peekaboo#peek(v:count1, '"', 0)
  vmap <expr> " peekaboo#peek(v:count1, '"', 1)
  imap <expr> <C-r> peekaboo#peek(1, "<C-r>",  0)
endif
" }}}

" ======== Surround ======== {{{
if dein#tap('vim-surround')
  nmap cs  <Plug>Csurround
  nmap cS  <Plug>CSurround
  nmap ds  <Plug>Dsurround
  nmap ys  <Plug>Ysurround
  nmap yS  <Plug>YSurround
  nmap yss <Plug>Yssurround
  nmap ySS <Plug>YSsurround
  vmap S   <Plug>VSurround
  vmap gS  <Plug>VgSurround
endif
" }}}

" ======== AutoPairs ======== {{{
if dein#tap('auto-pairs')
  let g:AutoPairsShortcutBackInsert = '<C-b>'
  let g:AutoPairsMapBS    = 1 " <BS>
  let g:AutoPairsMapCR    = 1 " <CR>
  let g:AutoPairsMapSpace = 1 " <Space>
endif
" }}}

" ======== Commentary ======== {{{
if dein#tap('vim-commentary')
  vmap gc <Plug>Commentary
  nmap gc <Plug>Commentary
  omap gc <Plug>Commentary
  nmap gcc <Plug>CommentaryLine
  nmap cgc <Plug>ChangeCommentary
  nmap gcu <Plug>Commentary<Plug>Commentary
endif
" }}}

" ======== MultipleCursors ======== {{{
if dein#tap('vim-multiple-cursors')
  let g:multi_cursor_start_word_key = '<C-n>'
  let g:multi_cursor_next_key       = '<C-n>'
  let g:multi_cursor_prev_key       = '<C-b>'
  let g:multi_cursor_skip_key       = '<C-x>'
  let g:multi_cursor_quit_key       = '<Esc>'
endif
" }}}

" ======== Undotree ======== {{{
if dein#tap('undotree')
  nmap U :<C-u>UndotreeToggle <bar> wincmd p<CR>
endif
" }}}

" ======== Tagbar ======== {{{
if dein#tap('tagbar')
  nnoremap <silent> <LocalLeader>d :<C-u>TagbarToggle<CR>
endif
" }}}

" ======== GitGutter ======== {{{
if dein#tap('vim-gitgutter')
  nmap sj <Plug>GitGutterNextHunk
  nmap sk <Plug>GitGutterPrevHunk

  nmap <LocalLeader>ss <Plug>GitGutterStageHunk
  nmap <LocalLeader>su :<C-u>call system('git reset '.expand('%')) <bar> GitGutterAll<CR>

  nmap <LocalLeader>sr <Plug>GitGutterUndoHunk

  " Toggle PreviewHunk
  nmap <silent> <LocalLeader>s<Space> <Plug>(helper-gitgutter-toggle-preview)
endif
" }}}

" ======== EasyAlign ======== {{{
if dein#tap('vim-easy-align')
  nmap ga <Plug>(EasyAlign)
  vmap ga <Plug>(LiveEasyAlign)
endif
" }}}

" ======== FZF ======== {{{
if dein#tap('fzf.vim')
  nnoremap <C-o> :Buffers<CR>
  nnoremap <C-p> :Files<CR>
  " `Opt-f` to search file contents
  nnoremap ƒ :Ag<Space>
endif
" }}}

" ======== FileType:markdown ======== {{{
if dein#tap('vim-markdown')
  autocmd MyAutoCmd FileType markdown
        \ nmap ]] <Plug>Markdown_MoveToNextHeader |
        \ nmap [[ <Plug>Markdown_MoveToPreviousHeader
endif
if dein#tap('vim-markdown-preview')
  autocmd MyAutoCmd FileType markdown
        \ nnoremap <silent> <CR> :<C-u>call Vim_Markdown_Preview_Local()<CR>
endif
" }}}
