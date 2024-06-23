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

function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done

  # If no main branch was found, fall back to master but return error
  echo master
  return 1
}

function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel develop development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return 0
    fi
  done

  echo develop
  return 1
}

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
alias    gbm='git branch --move'
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
alias    gcd='git checkout $(git_develop_branch)'
alias    gcm='git checkout $(git_main_branch)'
alias   grhb='git reset --soft HEAD~'
# alias  gbonm='git for-each-ref --format="%(refname:short), %(authorname), %(committerdate:relative), %(contents:subject)" --sort=-committerdate refs/remotes/ --no-merged | column -ts,'
alias    gbr='git branch --remote'
alias  gbonm='git for-each-ref --format="%(committerdate:relative) | %(authorname) | %(refname:short) | %(contents:subject)" --sort=-committerdate refs/remotes/ --no-merged'
alias   gbnm='git branch --no-merged'
alias  gcnn!='git commit --no-edit --no-verify --amend --allow-empty'
alias  gcoom='git checkout origin/$(git_main_branch)'
alias  gmnff='git merge --no-ff'
alias  grbim='git rebase -i $(git merge-base $(git_main_branch) HEAD)'
alias  grhbn='git reset --soft HEAD~ && git reset'
alias  gstai='git stash push --include-untracked'
alias gmnffs='git merge --no-ff -S'
alias   grev='git rev-parse --abbrev-ref HEAD'
alias  gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

alias  gclone='git clone'
alias gclone1='git clone --depth=1'

alias gf='git fetch'
alias gfa='git fetch --all'

alias ts='tig status'
alias ta='tig --all'

alias gco='git checkout'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gcb='git checkout -b'

alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gca!='git commit --verbose --all --amend'
alias gc!='git commit --verbose --amend'
alias gcn!='git commit --verbose --no-edit --amend'

alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdw='git diff --word-diff'

alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gms="git merge --squash"

alias gp='git push'
alias gpd='git push --dry-run'

alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'

alias grbm='git rebase $(git_main_branch)'
alias  grbom='git rebase origin/$(git_main_branch)'

alias gst='git stash'
alias gstall='git stash --all'
alias gsta='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'

alias gsi='git submodule init'
alias gsu='git submodule update'

alias gts='git tag --sign'
