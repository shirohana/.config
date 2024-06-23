if ! (( $+commands[zoxide] )); then
  print "zoxide.plugin.zsh: zoxide not found" >&2
  return 1
fi

source <(zoxide init zsh)
