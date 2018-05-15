function! helper#buffer#close_buffer_keep_windows () abort
  " If tries to close PLACEHOLDER, do nothing
  if <SID>is_placeholder() | return | endif

  " Print error message when tries to quit modified buffers
  " TODO: Find better way to get vanilla error message belongs to user locale
  if helper#buffer#is_modified('%')
    try | execute 'bw %' | catch | echoerr v:exception | endtry
    return
  endif

  if winnr('$') == 1
    execute 'bw %'
  else
    let current_bufnr = bufnr('')
    let current_winnr = winnr()
    let target_winnrs = helper#window#find_winnrs_of_bufnr(current_bufnr)

    if len(target_winnrs) == 1
      execute 'bp | bw '.current_bufnr
    else
      let placeholder_bufnr = <SID>ensure_placeholder()
      if placeholder_bufnr == current_bufnr
        execute 'bp'
      else
        call helper#window#change_wins_bufnr(target_winnrs, placeholder_bufnr)
        execute current_winnr.'wincmd w'
        execute 'bw '.current_bufnr
      endif
    endif
  endif
endfunction

function! helper#buffer#is_modified (bufnr) abort
  return getbufvar(a:bufnr, '&mod')
endfunction

function! helper#buffer#is_purely (bufnr) abort
  return bufname(a:bufnr) == '' && !helper#buffer#is_modified(a:bufnr)
endfunction

function! s:ensure_placeholder () abort
  let bufnr = helper#tab#getvar_current('hana', 'placeholder_bufnr', 0)

  if bufnr == 0 || !bufexists(bufnr)
    execute 'enew | file PLACEHOLDER'

    setlocal nobuflisted
    setlocal noswapfile
    setlocal nomodifiable
    setlocal buftype=nofile
    setlocal bufhidden=wipe

    let bufnr = bufnr('')
    call helper#tab#setvar_current('hana', 'placeholder_bufnr', bufnr)
  endif

  return bufnr
endfunction

function! s:is_placeholder () abort
  return &buftype == 'nofile' && bufname('%') == 'PLACEHOLDER'
endfunction
