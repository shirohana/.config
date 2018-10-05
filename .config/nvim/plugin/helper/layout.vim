let s:placeholder_bufnr = 0

function! helper#layout#CloseBufferInTab (tabnr, bufnr) abort
  let buffers = helper#tab#BufnrList(a:tabnr)
  let buf_index = index(buffers, a:bufnr)

  " Do nothing when buffer didn't contained in tab
  if buf_index == -1 | return | endif

  " Do nothing when tries to close PLACEHOLDER
  if <SID>is_placeholder() | return | endif

  " Print error message when tries to quit modified buffer or terminal
  " TODO: Find better way to get vanilla error message belongs to user locale
  if getbufvar(a:bufnr, '&modified') || &buftype == 'terminal'
    try | execute 'bw %' | catch | echoerr v:exception | endtry
    return
  endif

  let is_only_window = len(filter(tabpagebuflist(a:tabnr), 'v:val == '.a:bufnr)) == 0

  " Switch buffer of windows
  if !is_only_window
    " NOTE: This action may change current `tabpagenr` and/or `winnr`
    let placeholder_bufnr = <SID>ensure_placeholder()
    call helper#tab#SwitchWindowsByBufnr(a:tabnr, a:bufnr, placeholder_bufnr)
  endif

  if len(buffers) == 1
    enew
  else
    let next_buf_index = (buf_index + 1) == len(buffers)
          \ ? buf_index - 1
          \ : buf_index + 1
    let next_bufnr = get(buffers, next_buf_index, 0)

    " Switch buffer back of current window
    if next_bufnr > 0
      execute next_bufnr.'buffer'
    endif
  endif

  let contained_tabs = map(range(1, tabpagenr('$')), 'helper#tab#ContainsBuffer(v:val, '.a:bufnr.')')
  let contained_in_other_tabs = len(filter(contained_tabs, 'v:val == 1')) > 1

  " Perform close buffer
  if !contained_in_other_tabs
    try | execute 'bwipe '.a:bufnr | catch | endtry
  else
    if has_key(t:, 'CtrlSpaceList')
      call remove(t:CtrlSpaceList, a:bufnr)
    endif
  endif
endfunction

function! s:ensure_placeholder () abort
  let bufnr = s:placeholder_bufnr

  if bufnr == 0 || !bufexists(bufnr)
    enew | file PLACEHOLDER

    setlocal buflisted
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
