function! helper#edit#join_spaceless()
  execute 'normal! gJ'
  if matchstr(getline('.'), '\%'.col('.').'c.') =~ '\s'
    execute 'normal! dw'
  endif
endfun
