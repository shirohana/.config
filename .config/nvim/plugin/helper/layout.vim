let s:placeholder_bufnr = 0

function! helper#layout#CloseBufferInTab (tabnr, bufnr) abort
  " If tries to close PLACEHOLDER, do nothing
  if <SID>is_placeholder() | return | endif

  " Print error message when tries to quit modified buffer or terminal
  " TODO: Find better way to get vanilla error message belongs to user locale
  if getbufvar(a:bufnr, '&modified') || &buftype == 'terminal'
    try | execute 'bw %' | catch | echoerr v:exception | endtry
    return
  endif

  let modified_tabs = 0
  let original_tabnr = tabpagenr()

  let contained_tabs = 0

  for tabnr in range(1, tabpagenr('$'))
    if !helper#tab#ContainsBuffer(tabnr, a:bufnr) | continue | endif

    if tabnr == a:tabnr
      " Switch buffer of windows
      if winnr('$') == 1
        execute 'bp'
      else
        let placeholder_bufnr = <SID>ensure_placeholder()
        call helper#tab#SwitchWindowsByBufnr(tabnr, a:bufnr, placeholder_bufnr)
      endif
    endif

    let contained_tabs += 1
  endfor

  call helper#tab#Jump(original_tabnr)

  if contained_tabs <= 1
    execute 'bwipe '.a:bufnr
  else
    if has_key(t:, 'CtrlSpaceList')
      call remove(t:CtrlSpaceList, a:bufnr)
    endif
  endif
endfunction

function! s:ensure_placeholder () abort
  let bufnr = s:placeholder_bufnr

  if bufnr == 0 || !bufexists(bufnr)
    execute 'enew | file PLACEHOLDER'

    setlocal nobuflisted
    setlocal noswapfile
    setlocal nomodifiable
    setlocal buftype=nofile
    setlocal bufhidden=wipe

    let bufnr = bufnr('')
    let s:placeholder_bufnr = bufnr
  endif

  return bufnr
endfunction

function! s:is_placeholder ()
  return &buftype == 'nofile' && bufname('%') == 'PLACEHOLDER'
endfunction
