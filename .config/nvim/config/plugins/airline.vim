" Theme
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'

let g:airline_powerline_fonts = 1

" Enable `tabline`
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#show_tabs = 0
let g:airline#extensions#tabline#exclude_preview = 1
let g:airline#extensions#tabline#show_buffers = 1

let g:airline#extensions#tabline#buffer_idx_mode = 1

let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnametruncate = 12
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

let g:airline#extensions#tabline#keymap_ignored_filetypes = [
      \ 'nerdtree',
      \ 'vimfiler',
      \ ]
