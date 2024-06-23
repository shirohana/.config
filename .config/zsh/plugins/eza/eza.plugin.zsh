if ! (( $+commands[eza] )); then
  print "eza.plugin.zsh: eza not found" >&2
  return 1
fi

alias ls='eza'
alias  l='eza -ahlF --group-directories-first'
alias ll='eza -lhF --group-directories-first'
alias la='eza -aalF --group-directories-first'
alias lt='eza -aT --group-directories-first'
