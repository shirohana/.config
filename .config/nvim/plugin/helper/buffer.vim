function! helper#buffer#NextBuffer ()
  let buffers = helper#tab#BufnrList(tabpagenr())
  if len(buffers) == 0 | return | endif

  let buf_index = index(buffers, bufnr(''))
  let next_buf_index = buf_index == -1
        \ ? 0
        \ : (buf_index + 1) % len(buffers)

  execute buffers[next_buf_index].'buffer'
endfunction

function! helper#buffer#PreviousBuffer ()
  let buffers = helper#tab#BufnrList(tabpagenr())
  if len(buffers) == 0 | return | endif

  let buf_index = index(buffers, bufnr(''))
  let prev_buf_index = buf_index == -1
        \ ? -1
        \ : buf_index - 1

  execute buffers[prev_buf_index].'buffer'
endfunction
