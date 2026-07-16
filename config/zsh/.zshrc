ZSH="$HOME/.config/zsh"
ZSH_CACHE_DIR="$HOME/.cache/zsh"
ZSH_COMPLETION_DIR="$ZSH_CACHE_DIR/completions"

export LANG=en_US.UTF-8
export EDITOR='nvim'
export LESS="-R"
export GPG_TTY=$TTY

# Required GitHub CLI installed:
# 1. brew install gh
# 2. gh auth login
# 3. gh extension install github/gh-copilot
_ENABLE_GITHUB_COPILOT=$(( ${+commands[gh]} ))

source "$ZSH/init.zsh"

unset _ENABLE_GITHUB_COPILOT

# 啟用選單選擇
zstyle ':completion:*' menu select

# 補全時顯示說明
zstyle ':completion:*' format '%F{yellow}-- %d --%f'

# 補全排序（命令靠前）
# zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=**'

# 補全時自動加上 `/` 或空格
# zstyle ':completion:*' list-dirs-first true

# mkdir -p "$ZSH_CACHE_DIR/completions"
# (( ${fpath[(Ie)"$ZSH_CACHE_DIR/completions"]} )) || fpath=("$ZSH_CACHE_DIR/completions" $fpath)

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export HUSKY=0
