let s:user_dictionary_key = 'user_dictionary'

function! helper#tab#setvar (tabnr, scope, key, value)
  " Initialize tabnr
  let tabnr = (type(a:tabnr) == v:t_string && len(a:tabnr) == 0)
        \ ? tabpagenr() : a:tabnr

  " Get dictionary from tabvar or create one
  let dict = get(gettabvar(tabnr, ''), s:user_dictionary_key, {})

  " Put dictionary into tabvar if didn't exists
  if empty(dict) | call settabvar(tabnr, s:user_dictionary_key, dict) | endif

  " Update dict.scope.key = value
  let scope = get(dict, a:scope, {})
  let scope[a:key] = a:value
  let dict[a:scope] = scope
endfunction

function! helper#tab#getvar (tabnr, scope, key, ...)
  " Initialize tabnr
  let tabnr = (type(a:tabnr) == v:t_string && len(a:tabnr) == 0)
        \ ? tabpagenr() : a:tabnr

  " Get dictionary from tabvar
  let dict = get(gettabvar(tabnr, ''), s:user_dictionary_key, {})

  return (has_key(dict, a:scope))
        \ ? get(dict[a:scope], a:key, get(a:000, 0)) : get(a:000, 0)
endfunction

function! helper#tab#ContainsBuffer (tabnr, bufnr)
  if exists('*ctrlspace#api#Buffers')
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
