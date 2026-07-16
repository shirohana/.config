zinit ice \
  from="gh-r" \
  atclone="./zoxide init zsh --no-cmd > zoxide.zsh" \
  atpull="%atclone" \
  src="zoxide.zsh"
zinit light ajeetdsouza/zoxide

if ! (( $+commands[zoxide] )); then
  print "zoxide.plugin.zsh: zoxide not found" >&2
  return 1
fi

function z() {
  __zoxide_z "$@" || return
  # Send xterm OSC 7 sequence to notify the new working dir
  print -Pn "\e]7;file://$HOST$PWD\a"
}
