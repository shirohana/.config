zinit ice wait lucid \
  from"gh-r"  \
  atclone"./fzf --zsh > fzf.zsh" \
  atpull"%atclone" \
  src"fzf.zsh"
zinit light junegunn/fzf

if ! (( $+commands[fzf] )); then
  print "fzf.plugin.zsh: fzf not found" >&2
  return 1
fi

if [[ -z "$FZF_DEFAULT_COMMAND" && $+commands[fd] ]]; then
  FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix'
  FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
