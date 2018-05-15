if executable('ag')
  let $FZF_DEFAULT_COMMAND="ag -g '' --hidden --path-to-ignore $NVIM/fzf.ignore"
  let $FZF_DEFAULT_OPTS='--height 20% --reverse --border --multi'
  command! -bang -nargs=* Ag
        \ call fzf#vim#ag(
        \ <q-args>,
        \ '--hidden --path-to-ignore $NVIM/fzf.ignore',
        \ <bang>0)
endif
