# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U compinit; compinit -u

ZSH="$HOME/.config/zsh"
ZSH_CACHE_DIR="$HOME/.cache/zsh"

# plugins=(eza fnm fzf git)
plugins=($(command ls "$ZSH/plugins"))

mkdir -p "$ZSH_CACHE_DIR/completions"
(( ${fpath[(Ie)"$ZSH_CACHE_DIR/completions"]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)

for lib_file ("$ZSH"/lib/*.zsh); do
  source "$lib_file"
done
unset lib_file

for plugin ($plugins); do
  source "$ZSH/plugins/$plugin/$plugin.plugin.zsh"
done
unset plugin
