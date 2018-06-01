function! helper#tab#Setvar (tabnr, scope, key, value)
  " Get dictionary from tabvar or create one
  let dict = get(gettabvar(a:tabnr, ''), a:scope, {})

  " Put dictionary into tabvar if didn't exists
  if empty(dict)
    call settabvar(a:tabnr, a:scope, dict)
  endif

  " Assign value
  let dict[a:key] = a:value
endfunction

function! helper#tab#Getvar (tabnr, scope, key, ...)
  " Get dictionary from tabvar
  let dict = get(gettabvar(a:tabnr, ''), a:scope, {})

  return get(dict, a:key, get(a:000, 0))
endfunction

function! helper#tab#BufnrList (tabnr)
  if get(g:, 'CtrlSpaceLoaded', 0)
    return map(ctrlspace#api#BufferList(a:tabnr), 'v:val["index"]')
  else if exists('*nvim_list_bufs')
    return filter(nvim_list_bufs(), 'buflisted(v:val)')
  else
    return filter(range(1, bufnr('$')), 'buflisted(v:val)')
  endif
endfunction

function! helper#tab#ContainsBuffer (tabnr, bufnr)
  if get(g:, 'CtrlSpaceLoaded', 0)
    return has_key(ctrlspace#api#Buffers(a:tabnr), a:bufnr)
  else
    return bufexists(a:bufnr) && getbufvar(a:bufnr, '&buflisted')
  endif
endfunction

function! helper#tab#SwitchWindowsByBufnr (tabnr, from_bufnr, to_bufnr) abort
  let bufnr_of_windows = tabpagebuflist(a:tabnr)

  let original_tabnr = tabpagenr()
  let original_winnr = tabpagewinnr(a:tabnr)

  for winnr in range(1, len(bufnr_of_windows))
    let bufnr = bufnr_of_windows[winnr - 1]

    if bufnr != a:from_bufnr | continue | endif

    execute a:tabnr.'tabdo '.winnr.'windo '.a:to_bufnr.'buffer | wincmd p | '.original_tabnr.'tabnext'
  endfor

  call helper#window#Jump(original_winnr)
  call helper#tab#Jump(original_tabnr)
endfunction

function! helper#tab#Jump (tabnr)
  if a:tabnr != tabpagenr()
    execute a:tabnr.'tabnext'
  endif
endfunction
