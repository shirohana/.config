nnoremap <silent> <Plug>(helper-gitgutter-toggle-preview) :<C-u>call helper#gitgutter#toggle_preview()<CR>

nnoremap <silent> <Plug>(close-buffer-keep-layout) :<C-u>call helper#layout#CloseBufferInTab(tabpagenr(), bufnr(''))<CR>

noremap <silent><Plug>(easymotion-fl-fix) :<C-u>call EasyMotion#SL(1, 0, 0) <bar> call helper#cursor#block()<CR>
noremap <silent><Plug>(easymotion-Fl-fix) :<C-u>call EasyMotion#SL(1, 0, 1) <bar> call helper#cursor#block()<CR>
noremap <silent><Plug>(easymotion-tl-fix) :<C-u>call EasyMotion#TL(1, 0, 0) <bar> call helper#cursor#block()<CR>
noremap <silent><Plug>(easymotion-Tl-fix) :<C-u>call EasyMotion#TL(1, 0, 1) <bar> call helper#cursor#block()<CR>
