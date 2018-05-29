let g:CtrlSpaceSetDefaultMapping = 0

let g:CtrlSpaceCacheDir = expand('$CACHE_DIR/ctrlspace')

let g:CtrlSpaceSearchTiming = 20

if executable('ag')
  let g:CtrlSpaceGlobCommand = 'ag -g "" --hidden --path-to-ignore $NVIM/fzf.ignore'
endif

command! CtrlSpaceBuffers
      \ call fzf#run({
      \ 'source': values(ctrlspace#api#Buffers(tabpagenr())),
      \ 'sink': 'e',
      \ 'down': '20%'
      \ })
