# Use emacs key bindings
bindkey -e

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# bindkey '\C-a'   beginning-of-line
# bindkey '\C-b'   backward-char
# bindkey '\C-e'   end-of-line
# bindkey '\C-d'   delete-char
# bindkey '\C-k'   kill-line
# bindkey '\C-n'   down-line-or-search
# bindkey '\C-p'   up-line-or-search
# bindkey '\C-r'   history-incremental-search-backward
# bindkey '^[[A' history-search-backward
# bindkey '^[[B' history-search-forward
bindkey "^[[1;5C" forward-word # ctrl+right
bindkey "^[[1;5D" backward-word # ctrl+left
bindkey "^[^[[C" forward-word # macOS: option+right
bindkey "^[^[[D" backward-word # macOS: option+left

setopt complete_in_word
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-}' 'r:|=*' 'l:|=* r:|=*'

my-backward-delete-word() {
    local WORDCHARS=${WORDCHARS//-}
    local WORDCHARS=${WORDCHARS//\/}
    zle backward-delete-word
}
zle -N my-backward-delete-word
bindkey '\C-w' my-backward-delete-word

export LANG=en_US.UTF-8
export EDITOR='nvim'
export GPG_TTY=$TTY

if [ "$(arch)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# bindkey -M emacs '^P' history-substring-search-up
# bindkey -M emacs '^N' history-substring-search-down

alias    i='nvim'
alias    v='nvim'
alias   vi='nvim'
alias   vI='nvim'
alias   Vi='nvim'
alias   VI='nvim'
alias   :e='nvim'
alias view='nvim -R'
alias   :q='exit'
alias  :qa='exit'

# if command -v ggrep &> /dev/null; then
#   unalias grep
#   alias   grep='ggrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
# fi
#
# if command -v tig &> /dev/null; then
#   alias ta='tig --all'
#   alias ts='tig status'
# fi

if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
