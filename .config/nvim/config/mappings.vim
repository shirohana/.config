" ======== Defaults ========
nmap s <Nop>
nmap Q <Nop>

" ======== Generic ========
" Better <Esc>
inoremap <C-l> <Esc>
vnoremap <C-l> <Esc>
" Really like the `beep beep` sounds
nnoremap <C-l> <Esc>
" Cancel highlight search
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>

" ======== Moving ========
" Move screen horizontally
nnoremap zl z8l
nnoremap zh z8h
" Jump to older cursor position
nnoremap <Bslash> <C-o>
" Jump to newer cursor position
nnoremap <Bar> <C-i>

" ======== Editing ========
" Insert one line above current line in -- INSERT --
inoremap OO <C-o>O
" Go to start/end of current line in -- INSERT --
inoremap <C-a> <C-o>I
inoremap <C-e> <C-o>A
" Clone paragraph
nnoremap yp yap<S-}>p

" ======== Command ========
" Go to start/end of current command
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" ======== Buffer ========
" Create New Buffer, using `Opt-t`
nnoremap <silent> † :<C-u>enew<CR>
" Save buffer
nnoremap <silent> <Leader>w :<C-u>write<CR>
" Wipe buffer
nmap <Leader>q <Plug>(close-buffer-keep-layout)
" Buffer Navigating, using `Opt+[` & `Opt+]`
if mapcheck('“', 'n') == '' && mapcheck('‘', 'n') == ''
  nnoremap <silent> “ :<C-u>bprev<CR>
  nnoremap <silent> ‘ :<C-u>bnext<CR>
endif

" ======== Window ========
" Create Vertical Split, using `<Space>[hl]`
nnoremap <silent> <Leader>h <C-w>v
nnoremap <silent> <Leader>l <C-w>v<C-w>l
" Create Horizontal Split, using `<Space>[jk]`
nnoremap <silent> <Leader>k <C-w>s
nnoremap <silent> <Leader>j <C-w>s<C-w>j
" Close Current Split, using `<Space>c`
nnoremap <silent> <Leader>c <C-w>q
" Window Navigating, using `Opt+[hjkl]`
nnoremap <silent> ˙ <C-w>h
nnoremap <silent> ∆ <C-w>j
nnoremap <silent> ˚ <C-w>k
nnoremap <silent> ¬ <C-w>l
" Next/Prev Window, using <Tab> and <S-Tab>
nnoremap <silent> <Tab>   <C-w>w
nnoremap <silent> <S-Tab> <C-w>W
" Window Resize, using arrow keys
nnoremap <silent> <Up>    :<C-u>resize -2<CR>
nnoremap <silent> <Down>  :<C-u>resize +2<CR>
nnoremap <silent> <Left>  :<C-u>vertical resize -4<CR>
nnoremap <silent> <Right> :<C-u>vertical resize +4<CR>

" ======== Tabpage ========
" Create New Tab, using `Opt-Shift-t`
nnoremap <silent> ˇ :<C-u>tabnew<CR>
" Close Tab, using `Opt-Shift-q`
nnoremap <silent> Œ :<C-u>tabclose<CR>
" Tab Navigating, using `Opt-Shift-[` & `Opt-Shift-]`
nnoremap <silent> ’ :<C-u>tabnext<CR>
nnoremap <silent> ” :<C-u>tabprevious<CR>

" ======== Terminal ========
" Enter -- NORMAL --
tnoremap <C-l> <C-\><C-n>

" ======== Temporary ========
nnoremap <F5> :so ~/.config/nvim/init.vim<CR>
