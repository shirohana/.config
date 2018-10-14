" ======== Defaults ========
nmap s <Nop>
nmap Q <Nop>
nmap K <Nop>

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
" Save Buffer
nnoremap <silent> <Leader>w :<C-u>write<CR>
" Wipe Buffer
nmap <Leader>q <Plug>(close-buffer-keep-layout)
" Save & Wipe Buffer
nnoremap <silent> <Leader>W :<C-u>write <bar> exec "normal \<Plug>(close-buffer-keep-layout)"<CR>
" Buffer Navigating, using `Opt+[` & `Opt+]`
nnoremap <silent> “ :<C-u>PrevBuffer<CR>
nnoremap <silent> ‘ :<C-u>NextBuffer<CR>

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
" Window Resize, using arrow keys
nnoremap <silent> <Up>    :<C-u>resize -2<CR>
nnoremap <silent> <Down>  :<C-u>resize +2<CR>
nnoremap <silent> <Left>  :<C-u>vertical resize -4<CR>
nnoremap <silent> <Right> :<C-u>vertical resize +4<CR>
" Toggle Zoom
nnoremap <silent> <Leader>z :<C-u>ToggleZoomWindow<CR>

" ======== Tabpage ========
" Create New Tab, using `Opt-Shift-t`
nnoremap <silent> ˇ :<C-u>tabnew<CR>
" Close Tab, using `Opt-Shift-q`
nnoremap <silent> Œ :<C-u>tabclose<CR>
" Next/Prev Tab, using `Opt-Shift-[` & `Opt-Shift-]`
nnoremap <silent> ’ :<C-u>tabnext<CR>
nnoremap <silent> ” :<C-u>tabprevious<CR>
" Next/Prev Tab, using <Tab> and <S-Tab>
nnoremap <silent> <Tab>   :<C-u>tabnext<CR>
nnoremap <silent> <S-Tab> :<C-u>tabprevious<CR>
" Tab Navigating, using `Opt+[1-9]`
nnoremap ¡ :<C-u>1tabn<CR>
nnoremap ™ :<C-u>2tabn<CR>
nnoremap £ :<C-u>3tabn<CR>
nnoremap ¢ :<C-u>4tabn<CR>
nnoremap ∞ :<C-u>5tabn<CR>
nnoremap § :<C-u>6tabn<CR>
nnoremap ¶ :<C-u>7tabn<CR>
nnoremap • :<C-u>8tabn<CR>
nnoremap ª :<C-u>9tabn<CR>

" ======== Terminal ========
" Enter -- NORMAL --
tnoremap <C-k> <C-\><C-n>

" ======== Temporary ========
nnoremap <F5> :so ~/.config/nvim/init.vim<CR>
