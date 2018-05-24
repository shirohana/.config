command SyntaxCheck echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
command ClearScrollback
      \ let b:original_scrollback = &scrollback |
      \ let &scrollback = 1 |
      \ call timer_start(20, { tid -> execute('let &scrollback = b:original_scrollback | unlet b:original_scrollback') })
