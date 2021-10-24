command! ClearScrollback
      \ let &scrollback = 1 |
      \ call timer_start(20, {-> execute('let &scrollback = 10000') })
      " \ call chansend(b:terminal_job_id, '') |

command! SyntaxCheck
      \ echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
