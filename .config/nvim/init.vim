if &compatible
  set nocompatible
endif

let $CACHE_DIR = expand('~/.cache/nvim')
let $NVIM = fnamemodify(expand('<sfile>'), ':h')
let $NVIM_CONFIG = expand('$NVIM/config')
let $NVIM_PLUGINS = expand('$NVIM/config/plugins')

function! s:source_file (path)
  execute 'source' expand('$NVIM/'.a:path)
endfunction

augroup MyAutoCmd
  autocmd!
  autocmd CursorHold *? syntax sync minlines=300
augroup END

" Initialize environment -- {{{
if has('vim_starting')
  " call <SID>source_file('helper.vim')
  call <SID>source_file('config/env.vim')
endif
" }}}

" Initialize dein.vim -- {{{
set runtimepath+=$CACHE_DIR/dein/repos/github.com/Shougo/dein.vim

let s:dein_path = expand('$CACHE_DIR/dein')
let s:plugins_path = expand('$NVIM/plugins.toml')

if dein#load_state(s:dein_path)
  call dein#begin(s:dein_path)

  call dein#load_toml(s:plugins_path)

  " Add or remove your plugins here:
  " call dein#add('Shougo/neosnippet.vim')
  " call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  " call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })

  call dein#end()
  call dein#save_state()
endif
" }}}

filetype plugin indent on
syntax enable

autocmd VimEnter * call dein#call_hook('post_source')

call <SID>source_file('config/plugin-mappings.vim')

call <SID>source_file('config/mappings.vim')
call <SID>source_file('config/theme.vim')

autocmd OptionSet guicursor noautocmd set guicursor=
