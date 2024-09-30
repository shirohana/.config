function _source_if_exists() {
  if [[ -f "$1" ]]; then
    source "$1"
  fi
}

ZSH="$HOME/.config/zsh"
ZSH_CACHE_DIR="$HOME/.cache/zsh"

plugins=($(command ls "$ZSH/plugins"))

for plugin ($plugins); do
  _source_if_exists "$ZSH/plugins/$plugin/$plugin.plugin.pre.zsh"
done
unset plugin

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U compinit; compinit -u

mkdir -p "$ZSH_CACHE_DIR/completions"
(( ${fpath[(Ie)"$ZSH_CACHE_DIR/completions"]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)

for lib_file ("$ZSH"/lib/*.zsh); do
  source "$lib_file"
done
unset lib_file

for plugin ($plugins); do
  _source_if_exists "$ZSH/plugins/$plugin/$plugin.plugin.zsh"
done
unset plugin


# Created by `pipx` on 2024-09-24 14:44:07
export PATH="$PATH:/Users/shirohana/.local/bin"
