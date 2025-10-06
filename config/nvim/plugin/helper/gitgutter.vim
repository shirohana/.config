let s:scope = 'helper_gitgutter'

function! helper#gitgutter#toggle_preview ()
  let key = 'preview_info'
  let tabnr = tabpagenr()

  let current_status = <SID>status()
  let saved_status = helper#tab#Getvar(tabnr, s:scope, key, {})

  if current_status.hunk_index < 0
    call gitgutter#utility#warn('cursor is not in a hunk')
  elseif !empty(saved_status) && <SID>compare_status(current_status, saved_status)
    try
      wincmd P | wincmd p | pclose
    catch
      call gitgutter#hunk#preview()
    endtry
  else
    call helper#tab#Setvar(tabnr, s:scope, key, current_status)
    call gitgutter#hunk#preview()
  endif
endfunction

function! s:compare_status (s1, s2)
  for key in keys(a:s1)
    if a:s1[key] != a:s2[key]
      return 0
    endif
  endfor

  return 1
endfunction

function! s:status ()
  return {
        \ 'bufnr': bufnr(''),
        \ 'changenr': changenr(),
        \ 'hunk_index': <SID>current_hunk_index()
        \ }
endfunction

function! s:current_hunk_index ()
  let bufnr = bufnr('')
  let hunks = gitgutter#hunk#hunks(bufnr)
  let l:index = -1

  for hunk in hunks
    if gitgutter#hunk#cursor_in_hunk(hunk)
      let l:index = index(hunks, hunk)
      break
    endif
  endfor

  return l:index
endfunction
