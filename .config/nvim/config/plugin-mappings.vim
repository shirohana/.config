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
  nmap gc <Plug>Commentary
  vmap gc <Plug>Commentary
  omap gc <Plug>Commentary
  nmap gcc <Plug>CommentaryLine
  nmap cgc <Plug>ChangeCommentary
  nmap gcu <Plug>Commentary<Plug>Commentary
endif
" }}}

" ======== CtrlSpace ======== {{{
if dein#tap('vim-ctrlspace')
  nnoremap <LocalLeader>c :<C-u>CtrlSpace<CR>
  " Buffer Navigating
  nnoremap <silent> ‘     :<C-u>CtrlSpaceGoDown<CR>
  nnoremap <silent> “     :<C-u>CtrlSpaceGoUp<CR>
  nnoremap <silent> <C-o> :<C-u>CtrlSpaceBuffers<CR>
endif
" }}}

" ======== EasyAlign ======== {{{
if dein#tap('vim-easy-align')
  nmap ga <Plug>(EasyAlign)
  vmap ga <Plug>(LiveEasyAlign)
endif
" }}}

" ======== EasyMotion ======== {{{
if dein#tap('vim-easymotion')
  " Line Navigating
  map <LocalLeader>j <Plug>(easymotion-sol-j)
  map <LocalLeader>J <Plug>(easymotion-j)
  map <LocalLeader>k <Plug>(easymotion-sol-k)
  map <LocalLeader>K <Plug>(easymotion-k)
  map <LocalLeader>h <Plug>(easymotion-linebackward)
  map <LocalLeader>l <Plug>(easymotion-lineforward)
  " Word Navigating
  map <LocalLeader>w  <Plug>(easymotion-w)
  map <LocalLeader>W  <Plug>(easymotion-W)
  map <LocalLeader>b  <Plug>(easymotion-b)
  map <LocalLeader>B  <Plug>(easymotion-B)
  map <LocalLeader>e  <Plug>(easymotion-e)
  map <LocalLeader>E  <Plug>(easymotion-E)
  map <LocalLeader>ge <Plug>(easymotion-ge)
  map <LocalLeader>gE <Plug>(easymotion-gE)
  " Repeating
  map <LocalLeader>n <Plug>(easymotion-n)
  map <LocalLeader>N <Plug>(easymotion-N)
  map <LocalLeader><Space> <Plug>(easymotion-repeat)
  " Word Searching
  nmap ss <Plug>(easymotion-sn)
  nmap sf <Plug>(easymotion-fl)
  nmap sF <Plug>(easymotion-Fl)
  nmap st <Plug>(easymotion-tl)
  nmap sT <Plug>(easymotion-Tl)
  " Word Searching (visual mode)
  vmap f <Plug>(easymotion-fl)
  vmap F <Plug>(easymotion-Fl)
  vmap t <Plug>(easymotion-tl)
  vmap T <Plug>(easymotion-Tl)
  " Word Searching (operating mode)
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
endif
" }}}

" ======== FZF ======== {{{
if dein#tap('fzf.vim')
  if mapcheck('<C-o>', 'n') == ''
    nnoremap <C-o> :<C-u>Buffers<CR>
  endif
  nnoremap <C-p> :<C-u>Files<CR>
  " `Opt-f` to search file contents
  nnoremap ƒ :<C-u>Ag<Space>
endif
" }}}

" ======== GitGutter ======== {{{
if dein#tap('vim-gitgutter')
  " Hunk Navigating
  nmap sj <Plug>GitGutterNextHunk
  nmap sk <Plug>GitGutterPrevHunk
  " Hunk Staging
  nmap     <LocalLeader>ss <Plug>GitGutterStageHunk
  nnoremap <LocalLeader>su :<C-u>call system('git reset '.expand('%')) <bar> GitGutterAll<CR>
  " Hunk Actions
  nmap <LocalLeader>sr <Plug>GitGutterUndoHunk
  " Toggle Preview Hunk
  nmap <silent> <LocalLeader>s<Space> <Plug>(helper-gitgutter-toggle-preview)
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

" ======== MultipleCursors ======== {{{
if dein#tap('vim-multiple-cursors')
  let g:multi_cursor_start_word_key = '<C-n>'
  let g:multi_cursor_next_key       = '<C-n>'
  let g:multi_cursor_prev_key       = '<C-b>'
  let g:multi_cursor_skip_key       = '<C-x>'
  let g:multi_cursor_quit_key       = '<Esc>'
endif
" }}}

" ======== NERDTree ======== {{{
if dein#tap('nerdtree')
  " Toggle NERDTree, using `Opt-;`
  nmap … :NERDTreeToggle<CR>
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

" ======== UltiSnips ======== {{{
if dein#tap('ultisnips')
  let g:UltiSnipsExpandTrigger = '<Tab>'
  let g:UltiSnipsJumpForwardTrigger = '<Tab>'
  let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
endif
" }}}

" ======== Undotree ======== {{{
if dein#tap('undotree')
  nmap U :<C-u>UndotreeToggle <bar> wincmd p<CR>
endif
" }}}

" ======== FileType:Markdown ======== {{{
if dein#tap('vim-markdown')
  autocmd MyAutoCmd FileType markdown
        \ map ]] <Plug>Markdown_MoveToNextHeader |
        \ map [[ <Plug>Markdown_MoveToPreviousHeader
endif
if dein#tap('vim-markdown-preview')
  autocmd MyAutoCmd FileType markdown
        \ nnoremap <silent> <CR> :<C-u>call Vim_Markdown_Preview_Local()<CR>
endif
" }}}
