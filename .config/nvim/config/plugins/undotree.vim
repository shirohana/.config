let g:undotree_WindowLayout = 4

if has('persistent_undo')
  set undodir=$CACHE_DIR/undofiles/
  set undofile
endif
