" Cancel default mappings
let g:CtrlSpaceSetDefaultMapping = 0

" NOTE: CtrlSpace will append '/.cs_cache' in it
let g:CtrlSpaceCacheDir = $CACHE_DIR

" We'll only used to search buffers, keep it lower
let g:CtrlSpaceSearchTiming = 20

" Replace fzf#buffers
command! CtrlSpaceBuffers
      \ call fzf#run({
      \ 'source': values(ctrlspace#api#Buffers(tabpagenr())),
      \ 'sink': 'e',
      \ 'down': '20%'
      \ })
