" Theme
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'

" Use unicode characters
let g:airline_powerline_fonts = 1

" airline # extensions # airline {{{
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tabs = 1

let g:airline#extensions#tabline#switch_buffers_and_tabs = 0

let g:airline#extensions#tabline#tab_nr_type = 0

" Buffer/Tab index mode (used to navigating by Opt-[1-9])
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Buffer name formmatter
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#fnametruncate = 12
" }}}

" airline # extensions # ctrlspace {{{
let g:airline#extensions#ctrlspace#enabled = 1
" }}}
