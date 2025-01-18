let s:scope = 'helper'

function! helper#window#Jump (winnr)
  if a:winnr != winnr()
    execute a:winnr.'wincmd w'
  endif
endfunction

function! helper#window#SwitchBufferOfTwoWindows (a_winnr, b_winnr) abort
  let original_winnr = winnr()

  let a_bufnr = winbufnr(a:a_winnr)
  let b_bufnr = winbufnr(a:b_winnr)

  execute a:a_winnr.'windo '.b_bufnr.'buffer | '.a:b_winnr.'windo '.a_bufnr.'buffer'

  call helper#window#Jump(original_winnr)
endfunction

function! helper#window#SwapTo (direction)
  let a_winnr = winnr()
  execute 'wincmd '.a:direction
  let b_winnr = winnr()
  call helper#window#SwitchBufferOfTwoWindows(a_winnr, b_winnr)
endfunction

function! helper#window#ToggleZoom ()
  let key = 'is_zoomed'
  let winnr = winnr()

  let is_zoomed = helper#window#Getvar(winnr, s:scope, key, 0)

  if is_zoomed
    wincmd =
  else
    wincmd _ | wincmd |
  endif

  call helper#window#Setvar(winnr, s:scope, key, !is_zoomed)
endfunction

function! helper#window#Setvar (winnr, scope, key, value)
  " Get dictionary from winvar or create one
  let dict = get(getwinvar(a:winnr, ''), a:scope, {})

  " Put dictionary into winvar if didn't exists
  if empty(dict)
    call setwinvar(a:winnr, a:scope, dict)
  endif

  " Assign value
  let dict[a:key] = a:value
endfunction

function! helper#window#Getvar (winnr, scope, key, ...)
  " Get dictionary from winvar
  let dict = get(getwinvar(a:winnr, ''), a:scope, {})

  return get(dict, a:key, get(a:000, 0))
endfunction
