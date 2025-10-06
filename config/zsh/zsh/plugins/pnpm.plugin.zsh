# WIP 目前 cd 進不同目錄時，不會自動載入不同版本的 pnpm 補全，待更新

_load_pnpm_completion() {
  (( $+commands[pnpm] )) || return

  local pnpm_version="$(command pnpm -v)"
  local completion_file="$ZSH_COMPLETION_DIR/pnpm--$pnpm_version/_pnpm.zsh"

  mkdir -p "$(dirname "$completion_file")"

  [[ -f "$completion_file" ]] || command pnpm completion zsh > "$completion_file"

  zinit ice wait lucid blockf
  zinit snippet "$completion_file"
}

_load_pnpm_completion
unfunction _load_pnpm_completion

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
