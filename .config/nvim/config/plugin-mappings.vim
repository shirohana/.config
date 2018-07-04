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
  " Show ctrlspace menu
  nnoremap <LocalLeader>c :<C-u>CtrlSpace<CR>
  " Buffer Navigating
  nnoremap <silent> <C-o> :<C-u>CtrlSpaceBuffers<CR>
  " Create New Workspace, using <Opt-Shift-w>
  nnoremap <silent> „ :<C-u>CtrlSpaceNewWorkspace<CR>
  " Load Workspace, using <Opt-w>
  nnoremap <silent> ∑ :<C-u>LoadWorkspace<CR>
  " Save workspace, using <Opt-s>
  nnoremap <silent> ß :<C-u>SaveWorkspace<CR>
  " Save Workspace with Name, using <Opt-Shift-s>
  nnoremap <silent> Í :<C-u>SaveWorkspacePrompt<CR>
  " Rename tab
  nnoremap <silent> <LocalLeader>= :<C-u>RenameTabLabel<CR>
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
  " Refresh Gutter
  nnoremap <silent> <LocalLeader>sa :<C-u>GitGutterAll<CR>
  " Stage Current Hunk
  nmap <LocalLeader>ss <Plug>GitGutterStageHunk
  " Unstage Current File
  nnoremap <silent> <LocalLeader>su :<C-u>call system('git reset '.expand('%')) <bar> GitGutterAll<CR>
  " Hard Reset Current Hunk
  nmap <LocalLeader>sr <Plug>GitGutterUndoHunk
  " Toggle Hunk Preview
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

" ======== SplitJoin ======== {{{
if dein#tap('splitjoin.vim')
  nmap gS <Plug>SplitjoinSplit
  nmap gJ <Plug>SplitjoinJoin
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
  autocmd MyAutoCmd FileType markdown map ]] <Plug>Markdown_MoveToNextHeader
  autocmd MyAutoCmd FileType markdown map [[ <Plug>Markdown_MoveToPreviousHeader
endif
if dein#tap('vim-markdown-preview')
  autocmd MyAutoCmd FileType markdown
        \ nnoremap <buffer> <silent> <CR> :<C-u>call Vim_Markdown_Preview_Local()<CR>
endif
" }}}
