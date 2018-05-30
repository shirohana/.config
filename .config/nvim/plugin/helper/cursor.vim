function! helper#cursor#block ()
  silent execute "!printf '\<Esc>]50;CursorShape=0\x7' > $TTY"
endfunction
