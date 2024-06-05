# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U compinit; compinit -u

# Use emacs key bindings
bindkey -e

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

# bindkey '\C-a'   beginning-of-line
# bindkey '\C-b'   backward-char
# bindkey '\C-e'   end-of-line
# bindkey '\C-d'   delete-char
# bindkey '\C-k'   kill-line
# bindkey '\C-n'   down-line-or-search
# bindkey '\C-p'   up-line-or-search
# bindkey '\C-r'   history-incremental-search-backward
# bindkey '^[[B' history-search-forward
# bindkey '^[[A' history-search-backward

export LANG=en_US.UTF-8
export EDITOR='nvim'
export GPG_TTY=$TTY

setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

if [ "$(arch)" = "arm64" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/usr/local/bin/brew shellenv)"
fi

source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if command -v fnm &> /dev/null; then
  eval "$(fnm env --use-on-cd)"
  source <(fnm completions --shell zsh)
fi

if command -v pnpm &> /dev/null; then
  export PNPM_HOME="/Users/shirohana/Library/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
  alias   p='pnpm'
  alias pex='pnpm exec'
  alias pdx='pnpm dlx'
  alias  pa='pnpm add'
  alias pag='pnpm add --global'
  alias pad='pnpm add --save-dev'
  alias pap='pnpm add --save-peer'
  alias pin='pnpm install'
  alias pls='pnpm list'
  alias prm='pnpm remove'
  alias  pu='pnpm update'
  alias pui='pnpm update --interactive --latest'
fi

alias    i='nvim'
alias    v='nvim'
alias   vi='nvim'
alias   vI='nvim'
alias   Vi='nvim'
alias   VI='nvim'
alias   :e='nvim'
alias view='nvim -R'
alias   :q='exit'
alias  :qa='exit'

# if command -v ggrep &> /dev/null; then
#   unalias grep
#   alias   grep='ggrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
# fi
#
# if command -v tig &> /dev/null; then
#   alias ta='tig --all'
#   alias ts='tig status'
# fi

if command -v eza &> /dev/null; then
  alias  l='eza -ahlF --group-directories-first'
  alias ls='eza'
  alias ll='eza -lF --group-directories-first'
  alias la='eza -alF --group-directories-first'
  alias lt='eza -alTF --group-directories-first -I="node_modules|.git|.expo"'
fi

if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi


# ------------------------------
# Git (moving from my previous .zshrc)
# ------------------------------

# function git_list_no_merged() {
#   git for-each-ref --sort=-committerdate refs/ --format="%(refname:short)|%(committerdate:relative)|%(authorname)" | while IFS='|' read -r branch date author; do
#     if [ -n "$(git branch --all --no-merged master | grep -w $branch)" ]; then
#       echo "$date | $author | $branch"
#     fi
#   done
# }

# function git_remotes() {
#   git remote -v | awk '{print $1}' | sort | uniq
# }

# function git_is_remote_branch() {
#   # if input starts with remotes/, it's a remote branch
#   # if input starts with a remote name, it's a remote branch
#   # otherwise, it's a local branch
#   if [[ "$1" == remotes/* ]]; then
#     return 0
#   fi
#   if git_remotes | grep -q "^$1$"; then
#     return 0
#   fi
#   return 1
# }

# function gbd() {
#   for branch in "$@"; do
#     if git_is_remote_branch "$branch"; then
#       remote=${branch%%/*}
#       git push "$remote" ":${branch#$remote/}"
#       # if there's a matched local branch, delete it
#       if git branch -a | grep -q "$branch"; then
#         git branch -d "${branch#$remote/}"
#       fi
#     else
#       git branch -d "$branch"
#     fi
#   done
# }

function gbdo() {
  git branch -d "$@";
  git push origin ":$@";
}

function gcnm() {
  now=$(TZ='Asia/Taipei' date +"%Y-%m-%d %H:%M:%S")
  gitstat=$(git diff --cached --shortstat)
  git commit --no-verify -m "$now ->$gitstat"
}

function gcanm() {
  git add .
  gcnm
}

function gccb() {
  # Copy current branch name to clipboard
  git_branch=$(git_current_branch | tr -d '\n')
  echo -n "$git_branch" | pbcopy
  echo "Copied '$git_branch'"
}

function gbl() {
  git branch --list "$1" | sed -e 's/^[* ]*//' | sort
}

function git_remove_all_merged_local_branches() {
  git branch --merged | grep -v "^\*" | grep -v $(git_main_branch) | xargs git branch -d
}

# alias  gcanm='git commit --no-verify -m="$(git diff --cached --numstat | wc -l)"'

alias ga='git add'
alias gau='git add --update'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsn='git bisect new'
alias gbso='git bisect old'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'

alias      g='git status'
alias     gs='git status'
alias    gbf='git branch -f'
alias    gbm='git branch -m'
alias    gms='git branch --merged | grep -v "^\*" | grep -v $(git_main_branch)'
alias    gcn='git commit -v --no-verify'
alias    gcs='git commit -vS'
alias    gdh='git checkout HEAD --detach'
alias     gl='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)"'
alias    gla='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias     gz='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias    glp='git log --abbrev-commit --decorate --date=relative --format=format:"%C(yellow)%h%C(reset) %C(bold green)%as%C(reset) - %C(dim white)%s%C(reset) %C(reset)%C(bold yellow)%d%C(reset)" --first-parent'
alias  glpom='git log --abbrev-commit --decorate --date=relative --format=format:"%C(yellow)%h%C(reset) %C(bold green)%as%C(reset) - %C(dim white)%s%C(reset) %C(reset)%C(bold yellow)%d%C(reset)" --first-parent origin/$(git_main_branch)'
alias    gmb='git merge-base'
alias   gmbm='git merge-base $(git_main_branch)'
alias   gmbh='git merge-base $(git_main_branch) HEAD'
alias  gmbom='git merge-base origin/$(git_main_branch)'
alias    gmt='git mergetool --no-prompt'
alias    gpl='git push local'
alias   gplf='git push local --force-with-lease'
alias   gplh='git push local HEAD'
alias  gplhf='git push local HEAD --force-with-lease'
alias    gpo='git push origin'
alias   gpof='git push origin --force-with-lease'
alias   gpoh='git push origin HEAD'
alias  gpohf='git push origin HEAD --force-with-lease'
alias    grh='git reset'
alias    grp='git remote prune'
alias    gtv='git tag -l'
alias   gbfm='git branch -f $(git_main_branch) origin/$(git_main_branch)'
alias   gcn!='git commit -v --no-verify --amend'
alias   gcom='git checkout $(git_main_branch)'
alias   grhb='git reset --soft HEAD~'
# alias  gboum='git for-each-ref --format="%(refname:short), %(authorname), %(committerdate:relative), %(contents:subject)" --sort=-committerdate refs/remotes/ --no-merged | column -ts,'
alias  gboum='git for-each-ref --format="%(committerdate:relative) | %(authorname) | %(refname:short) | %(contents:subject)" --sort=-committerdate refs/remotes/ --no-merged'
alias  gcnn!='git commit --no-edit --no-verify --amend --allow-empty'
alias  gcoom='git checkout origin/$(git_main_branch)'
alias  gmnff='git merge --no-ff'
alias  grbim='git rebase -i $(git merge-base $(git_main_branch) HEAD)'
alias  grbom='git rebase origin/$(git_main_branch)'
alias  grhbn='git reset --soft HEAD~ && git reset'
alias  gstai='git stash push --include-untracked'
alias gmnffs='git merge --no-ff -S'
alias   grev='git rev-parse --abbrev-ref HEAD'

alias  gclone='git clone'
alias gclone1='git clone --depth=1'
