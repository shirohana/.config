command! ClearScrollback
      \ let &scrollback = 1 |
      \ call chansend(b:terminal_job_id, '') |
      \ call timer_start(20, {-> execute('let &scrollback = 10000') })

command! SyntaxCheck
      \ echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
