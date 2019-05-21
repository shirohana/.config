" ======== Global MapLeader ======== {{{
" Primary leader `<Space>` used in global mappings like:
"   save, close, buffer-navigating, etc.
" Secondary leader `;`  used in plugin mappings
let g:mapleader = "\<Space>"
let g:maplocalleader = ';'

" Disable default behavior
nnoremap <Space> <Nop>
nnoremap ,       <Nop>
nnoremap ;       <Nop>
" }}}

" ======== Editor Config ======== {{{
" Always use utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,shift_jis,default,latin1

" Use space
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
" }}}

" ======== Appearance ======== {{{
" Disable guicursor
set guicursor=
autocmd OptionSet guicursor noautocmd set guicursor=

" Use ruler
set colorcolumn=80,120
set cursorline
set nowrap
autocmd MyAutoCmd FileType markdown set wrap

" Editor padding
set scrolloff=2

" Rendering
set nolazyredraw
set ttyfast
" }}}

" ======== Behavior ======== {{{
" Fix backspace (seems no need in NeoVim)
set backspace=indent,eol,start

" Allow hidden buffers
set hidden

" Enable error bells (I really like this <3)
set belloff=
set errorbells
" }}}

" ======== Other ======== {{{
set showcmd
let g:force_fix_easymotion_cursor = 1
" }}}
