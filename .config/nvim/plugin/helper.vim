nnoremap <silent> <Plug>(helper-gitgutter-toggle-preview) <Cmd>call helper#gitgutter#toggle_preview()<CR>

nnoremap <silent> <Plug>(close-buffer-keep-layout) <Cmd>call helper#layout#CloseBufferInTab(tabpagenr(), bufnr(''))<CR>

" noremap <silent><Plug>(easymotion-fl-fix) <Cmd>call EasyMotion#SL(1, 0, 0)<Bar>call helper#cursor#block()<CR>
" noremap <silent><Plug>(easymotion-Fl-fix) <Cmd>call EasyMotion#SL(1, 0, 1)<Bar>call helper#cursor#block()<CR>
" noremap <silent><Plug>(easymotion-tl-fix) <Cmd>call EasyMotion#TL(1, 0, 0)<Bar>call helper#cursor#block()<CR>
" noremap <silent><Plug>(easymotion-Tl-fix) <Cmd>call EasyMotion#TL(1, 0, 1)<Bar>call helper#cursor#block()<CR>

command! NextBuffer
      \ call helper#buffer#NextBuffer()

command! PrevBuffer
      \ call helper#buffer#PreviousBuffer()

command! WindowSwapLeft
      \ call helper#window#SwapTo('h')

command! WindowSwapDown
      \ call helper#window#SwapTo('j')

command! WindowSwapUp
      \ call helper#window#SwapTo('k')

command! WindowSwapRight
      \ call helper#window#SwapTo('l')

command! ToggleZoomWindow
      \ call helper#window#ToggleZoom()

command! RenameTabLabel
      \ call helper#ctrlspace#RenameTabLabelPrompt()

command! LoadWorkspace
      \ call helper#ctrlspace#LoadWorkspace()

command! SaveWorkspace
      \ call helper#ctrlspace#SaveWorkspace()

command! SaveWorkspacePrompt
      \ call helper#ctrlspace#SaveWorkspacePrompt()
