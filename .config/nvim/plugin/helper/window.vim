function! helper#window#Jump (winnr)
  if a:winnr != winnr()
    execute a:winnr.'wincmd w'
  endif
endfunction
