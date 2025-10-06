function _source_files() {
  local file
  for file ($@); do
    source "$file"
  done
  unset file
}

_source_files $ZSH/plugins/*.plugin.pre.zsh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ ! -f "$HOMEBREW_PREFIX/opt/zinit/zinit.zsh" ]]; then
  print "zinit.zsh: zinit.zsh not found at $HOMEBREW_PREFIX/opt/zinit" >&2
  return 1
fi

source "$HOMEBREW_PREFIX/opt/zinit/zinit.zsh"

zinit ice depth=1
zinit light romkatv/powerlevel10k

zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

zinit ice wait lucid blockf
zinit light zsh-users/zsh-completions

zinit ice wait lucid atload"!_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid atload"
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey -M emacs '^P' history-substring-search-up
  bindkey -M emacs '^N' history-substring-search-down
"
zinit light zsh-users/zsh-history-substring-search

mkdir -p "$ZSH_CACHE_DIR/completions"

_source_files $ZSH/lib/*.zsh
_source_files $ZSH/plugins/*.plugin.zsh

unfunction _source_files
