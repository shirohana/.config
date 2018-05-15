let s:user_dictionary_key = 'user_dictionary'

function! helper#tab#setvar (tabnr, scope, key, value)
  let l:dict = get(gettabvar(a:tabnr, ''), s:user_dictionary_key, {})

  let no_user_dictionary = empty(dict)

  let l:scope = get(l:dict, a:scope, {})
  let l:scope[a:key] = a:value

  let l:dict[a:scope] = l:scope

  if no_user_dictionary
    call settabvar(a:tabnr, s:user_dictionary_key, l:dict)
  endif
endfunction

function! helper#tab#setvar_current (scope, key, value)
  call helper#tab#setvar(tabpagenr(), a:scope, a:key, a:value)
endfunction

function! helper#tab#getvar (tabnr, scope, key, ...)
  let dict = get(gettabvar(a:tabnr, ''), s:user_dictionary_key, {})
  if has_key(dict, a:scope)
    return get(dict[a:scope], a:key, get(a:000, 0))
  else
    return get(a:000, 0)
  endif
endfunction

function! helper#tab#getvar_current (scope, key, ...)
  return helper#tab#getvar(tabpagenr(), a:scope, a:key, a:1)
endfunction
