function! helper#ctrlspace#LoadWorkspace ()
  call fzf#run({
        \ 'source': ctrlspace#workspaces#Workspaces(),
        \ 'sink': function('<SID>load_workspace'),
        \ 'down': '20%'
        \ })
endfunction

function! helper#ctrlspace#SaveWorkspace ()
  let name = ctrlspace#workspaces#ActiveWorkspace().Name
  if len(name) > 0
    call <SID>save_workspace(name)
  else
    call helper#ctrlspace#SaveWorkspacePrompt('')
  endif
endfunction

function! helper#ctrlspace#SaveWorkspacePrompt (...)
  let name = len(a:000) > 0
        \ ? a:000[0]
        \ : ctrlspace#workspaces#ActiveWorkspace().Name
  let name = input('⌗  Save current workspace as: ', name)
  redraw
  call <SID>save_workspace(name)
endfunction

function! helper#ctrlspace#RenameTabLabelPrompt (...)
  if len(a:000) > 0
    let label = a:000[0]
  else
    let tabnr = tabpagenr()
    let label = ctrlspace#util#Gettabvar(tabnr, "CtrlSpaceLabel")
    let label = input('⌗  Label for tab '.tabnr.': ', label)
    redraw
  endif

  call <SID>tab_label(label)
  call <SID>refresh_tabline()
endfunction

function! s:refresh_tabline ()
  call airline#extensions#tabline#ctrlspace#invalidate()
  let &tabline = &tabline
endfunction

function! s:load_workspace (name)
  call ctrlspace#workspaces#LoadWorkspace(0, a:name)
endfunction

function! s:save_workspace (name)
  call ctrlspace#workspaces#SaveWorkspace(a:name)
endfunction

function! s:tab_label (label)
  call ctrlspace#tabs#SetTabLabel(tabpagenr(), a:label, 0)
endfunction
