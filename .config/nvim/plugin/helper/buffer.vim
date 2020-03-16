function! helper#buffer#GoNthBuffer (index)
  let buffers = helper#tab#BufnrList(tabpagenr())
  let buf_len = len(buffers)

  if buf_len == 0 | return | endif

  let buf_index = type(a:index) == v:t_number
        \ ? (a:index < 0 ? 0 : (a:index < buf_len ? a:index : buf_len - 1))
        \ : (buf_len + (index(buffers, bufnr('')) + str2nr(a:index)) % buf_len) % buf_len

  execute buffers[buf_index].'buffer'
endfunction

function! helper#buffer#NextBuffer ()
  call helper#buffer#GoNthBuffer('+1')
endfunction

function! helper#buffer#PreviousBuffer ()
  call helper#buffer#GoNthBuffer('-1')
endfunction
