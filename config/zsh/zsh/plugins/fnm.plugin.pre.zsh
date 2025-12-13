if ! (( $+commands[fnm] )); then
  print "fnm.plugin.zsh: fnm not found" >&2
  return 1
fi

source <(fnm env --use-on-cd --shell zsh)
