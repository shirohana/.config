bindkey -e

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

_backward-delete-word() {
  WORDCHARS=${WORDCHARS//[-.\/=]}
  zle backward-delete-word
}
zle -N _backward-delete-word
bindkey '\C-w' _backward-delete-word

setopt complete_in_word
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'
