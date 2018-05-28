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
