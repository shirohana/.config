let g:ulti_expand_or_jump_res = 0 " default value, just set once

function! helper#ultisnips#ExpandOrJump ()
  call UltiSnips#ExpandSnippetOrJump()
  return g:ulti_expand_or_jump_res
endfunction
