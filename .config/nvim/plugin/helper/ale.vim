function! s:Open() abort
    let l:item_list = get(b:, 'ale_preview_item_list', [])
    let l:index = getpos('.')[1] - 1
    let l:item = get(l:item_list, l:index, {})

    if empty(l:item)
        return
    endif

    wincmd p

    call ale#util#Open(
    \   l:item.filename,
    \   l:item.line,
    \   l:item.column,
    \   {'open_in': 'current-buffer'},
    \)
endfunction

function! helper#ale#OpenSelection() abort
    call s:Open()
endfunction
