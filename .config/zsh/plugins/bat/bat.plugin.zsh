if ! (( $+commands[bat] )); then
  print "bat.plugin.zsh: bat not found" >&2
  return 1
fi

alias cat='bat'
