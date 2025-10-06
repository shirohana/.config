if [[ -z "$_ENABLE_GITHUB_COPILOT" ]]; then
  return 0
fi

zinit ice wait lucid \
  atload"
    bindkey '÷' zsh_gh_copilot_suggest # '÷' = Opt+/
    bindkey '¿' zsh_gh_copilot_explain # '¿' = Opt+Shift+/
  "
zinit light loiccoyle/zsh-github-copilot
