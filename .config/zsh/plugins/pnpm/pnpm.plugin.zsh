if ! (( $+commands[pnpm] )); then
  print "pnpm.plugin.zsh: pnpm not found" >&2
  return 1
fi

export PNPM_HOME="/Users/shirohana/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

alias   p='pnpm'
alias pin='pnpm install'
alias pls='pnpm list'
alias  pa='pnpm add'
alias pag='pnpm add --global'
alias pad='pnpm add --save-dev'
alias pap='pnpm add --save-peer'
alias prm='pnpm remove'
alias  pu='pnpm update'
alias pui='pnpm update --interactive --latest'
alias pex='pnpm exec'
alias pdx='pnpm dlx'
