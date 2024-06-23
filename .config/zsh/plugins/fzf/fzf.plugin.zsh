if ! (( $+commands[fzf] )); then
  print "fzf.plugin.zsh: fzf not found" >&2
  return 1
fi

source <(fzf --zsh)

if [[ -z "$FZF_DEFAULT_COMMAND" ]]; then
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix'
  fi
fi

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
