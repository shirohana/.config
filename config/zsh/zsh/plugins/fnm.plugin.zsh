zinit ice wait lucid blockf \
  as"completion" \
  from"gh-r" \
  atclone"./fnm completions --shell zsh > _fnm.zsh" \
  atpull"%atclone"
zinit light @Schniz/fnm

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
