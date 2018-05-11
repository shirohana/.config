function! helper#window#change_wins_bufnr (from_winnrs, to_bufnr) abort
  for i_winnr in a:from_winnrs
    execute i_winnr.'windo '.a:to_bufnr.'buffer'
  endfor
endfunction

function! helper#window#find_winnrs_of_bufnr (bufnr) abort
  let winnrs = []

  let win_amount = winnr('$')
  let i_winnr = 1

  while i_winnr <= win_amount
    if winbufnr(i_winnr) == a:bufnr
      call add(winnrs, i_winnr)
    endif
    let i_winnr = i_winnr + 1
  endwhile

  return winnrs
endfunction
