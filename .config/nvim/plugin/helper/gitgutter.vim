function! helper#gitgutter#toggle_preview () abort
  let current_status = <SID>status()
  let status = helper#tab#getvar_current('gitgutter', 'preview_info', {})

  if current_status.hunk_index < 0
    call gitgutter#utility#warn('cursor is not in a hunk')
  elseif !empty(status) && <SID>compare_status(current_status, status)
    try
      wincmd P | wincmd p | pclose
    catch
      execute 'GitGutterPreviewHunk'
    endtry
  else
    call helper#tab#setvar_current('gitgutter', 'preview_info', current_status)
    execute 'GitGutterPreviewHunk'
  endif
endfunction

function! s:compare_status (s1, s2) abort
  for key in keys(a:s1)
    if a:s1[key] != a:s2[key]
      return 0
    endif
  endfor
  return 1
endfunction

function! s:status () abort
  return {
        \ 'bufnr': bufnr(''),
        \ 'changenr': changenr(),
        \ 'hunk_index': <SID>current_hunk_index()
        \ }
endfunction

function! s:current_hunk_index () abort
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
