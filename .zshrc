# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U compinit; compinit -u

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
# bindkey '^[[B' history-search-forward
# bindkey '^[[A' history-search-backward

export LANG=en_US.UTF-8
export EDITOR='nvim'
export GPG_TTY=$TTY

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

if [ "$(arch)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

if [[ -f ~/.p10k.zsh ]]; then
  source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
  source ~/.p10k.zsh
fi

if command -v fnm &> /dev/null; then
  eval "$(fnm env --use-on-cd)"
  source <(fnm completions --shell zsh)
fi

if command -v pnpm &> /dev/null; then
  export PNPM_HOME="/Users/shirohana/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
  alias   p='pnpm'
  alias pex='pnpm exec'
  alias pdx='pnpm dlx'
  alias  pa='pnpm add'
  alias pag='pnpm add --global'
  alias pad='pnpm add --save-dev'
  alias pap='pnpm add --save-peer'
  alias pin='pnpm install'
  alias pls='pnpm list'
  alias prm='pnpm remove'
  alias  pu='pnpm update'
  alias pui='pnpm update --interactive --latest'
fi

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

if command -v eza &> /dev/null; then
  alias  l='eza -ahlF --group-directories-first'
  alias ls='eza'
  alias ll='eza -lF --group-directories-first'
  alias la='eza -alF --group-directories-first'
  alias lt='eza -alTF --group-directories-first -I="node_modules|.git|.expo"'
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
