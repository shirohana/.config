" Override default behavior
function! ctrlspace#keys#common#Quit(k)
  call ctrlspace#window#Kill(0, 1)
endfunction
