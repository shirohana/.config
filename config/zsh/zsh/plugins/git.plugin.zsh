function _git_wip_all() {
    git add --all
    git rm $(git ls-files --deleted) 2> /dev/null
    git commit --no-verify --no-gpg-sign --message "--wip-- $(TZ=Asia/Taipei date +'%Y-%m-%d %H:%M:%S') ->$(git diff --cached --shortstat) [skip ci]"
}

function git_checkout_detached_rev() {
  local ref
  ref=$(__git_prompt_git rev-parse --short $1 2> /dev/null) || return
  git checkout "$ref"
}

function git_sprint_branch() {
  local REMOTE='origin'
  local branch_name=$(git for-each-ref --sort=-committerdate --format='%(refname:short)' "refs/heads/sprint/*/*" "refs/heads/sprint/*" | head -n 1)
  if [ -z "$branch_name" ]; then
    branch_name=$(git for-each-ref --sort=-committerdate --format='%(refname:short)' "refs/remotes/$REMOTE/sprint/*/*" "refs/remotes/$REMOTE/sprint/*" | head -n 1)
  fi
  echo $branch_name
}

function git_log_all_graph() {
  local cmd='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) %C(bold green)(%ar)%C(reset) %C(dim white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
  if [ -z "$1" ]; then
    eval "$cmd"
  else
    # check all args
    local all_ignored_pattern=()
    for arg in "$@"; do
      all_ignored_pattern+=("**/$arg*")
      all_ignored_pattern+=("**/$arg**/*")
    done
    eval "$cmd" --not $(git for-each-ref --format='%(refname:short)' "${all_ignored_pattern[@]}")
  fi
}

function git_log_match() {
  if [ $# -eq 0 ]; then
    echo "Usage: $0 <pattern> [...patterns]"
  fi

  local branches=()
  for pattern in "$@"; do
    while IFS= read -r ref; do
      branches+=("$ref")
    done < <(git for-each-ref --format='%(refname:short)' "refs/heads/$pattern")
  done

  if [ -z "$branches" ]; then
    echo "Unable to match: '$branches'"
    return 2
  fi

  git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) %C(bold green)(%ar)%C(reset) %C(dim white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" "${branches[@]}"
}

alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'

alias  g='git status'
alias gs='git status'

alias gwl='git worktree list'
alias gwa='git worktree add'
alias gwd='git worktree remove'

alias gsi='git submodule init'
alias gsu='git submodule update'

alias   gf='git fetch'
alias  gfa='git fetch --all'
alias gfap='git fetch --all --prune'

alias    gp='git push'
alias   gpd='git push --dry-run'
alias   gpf='git push --force-with-lease'
alias   gpo='git push origin'
alias  gpof='git push origin --force-with-lease'
alias  gpoh='git push origin HEAD'
alias gpohu='git push origin HEAD -u'
alias gpohf='git push origin HEAD --force-with-lease'
alias   gpl='git push local'
alias  gplf='git push local --force-with-lease'
alias  gplh='git push local HEAD'
alias gplhf='git push local HEAD --force-with-lease'

alias  ga='git add'
alias gau='git add --update'

alias   grh='git reset'
alias  grhb='git reset --soft HEAD~'
alias grhbn='git reset --soft HEAD~ && git reset'

alias    gc='git commit --verbose'
alias   gca='git commit --verbose --all'
alias   gcn='git commit --verbose --no-verify'
alias   gc!='git commit --verbose --amend'
alias  gca!='git commit --verbose --all --amend'
alias  gcn!='git commit --verbose --no-verify --amend'
alias gcnn!='git commit --no-edit --no-verify --amend --allow-empty'
alias   gcs='git commit --verbose --gpg-sign'
alias  gcnm="git commit --no-verify --no-gpg-sign --message \"--wip-- \$(TZ=Asia/Taipei date +'%Y-%m-%d %H:%M:%S') ->\$(git diff --cached --shortstat) [skip ci]\""
# alias  gwip="git add --all; git rm \$(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message \"--wip-- \$(TZ=Asia/Taipei date +'%Y-%m-%d %H:%M:%S') ->\$(git diff --cached --shortstat) [skip ci]\""
alias gcanm="_git_wip_all"

alias    gb='git branch'
alias   gba='git branch --all'
alias   gbm='git branch --move'
alias   gbd='git branch --delete'
alias   gbD='git branch --delete --force'
alias   gbf='git branch --force'
alias  gbfd='git branch --force $(git_develop_branch) origin/$(git_develop_branch)'
alias  gbfm='git branch --force $(git_main_branch) origin/$(git_main_branch)'
alias   gbr='git branch --remote'
alias  gbnm='git branch --no-merged'
alias  gbms='git branch --merged | grep -v "^\*" | grep -v $(git_main_branch)'
alias gboum='git for-each-ref --format="%(committerdate:relative) | %(authorname) | %(refname:short) | %(contents:subject)" --sort=-committerdate refs/remotes/ --no-merged'
alias  gccb='git_copy_current_branch'

alias    gl='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) %C(bold green)(%ar)%C(reset) %C(dim white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)"'
alias    gz='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) %C(bold green)(%ar)%C(reset) %C(dim white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias   glp='git log --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) %C(bold green)%as%C(reset) %C(dim white)%s%C(reset) %C(reset)%C(bold yellow)%d%C(reset)" --first-parent'
alias glpom='git log --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) %C(bold green)%as%C(reset) %C(dim white)%s%C(reset) %C(reset)%C(bold yellow)%d%C(reset)" --first-parent origin/$(git_main_branch)'
alias   glg='git_log_match'

alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias  gds='git diff --staged'
alias  gdw='git diff --word-diff'

alias  gco='git checkout'
alias  gcb='git checkout -b'
alias  gct='git checkout --track'
alias  gcd='git checkout $(git_develop_branch)'
alias  gcm='git checkout $(git_main_branch)'
alias  gdh='git checkout HEAD --detach'
alias gcom='git checkout origin/$(git_main_branch)'
alias gcdh='git_checkout_detached_rev'

alias   grb='git rebase'
alias  grba='git rebase --abort'
alias  grbc='git rebase --continue'
alias  grbi='git rebase --interactive'
alias  grbm='git rebase $(git_main_branch)'
alias  grbd='git rebase $(git_develop_branch)'
alias grbod='git rebase origin/$(git_develop_branch)'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbid='git rebase --interactive $(git merge-base $(git_develop_branch) HEAD)'
alias grbim='git rebase --interactive $(git merge-base $(git_main_branch) HEAD)'
alias grbis='git rebase --interactive $(git merge-base $(git_sprint_branch) HEAD)'

alias     gm='git merge --log'
alias    gma='git merge --abort'
alias    gmc='git merge --continue'
alias    gms='git merge --log --squash'
alias  gmnff='git merge --log --no-ff'
alias gmnffs='git merge --log --no-ff --gpg-sign'

alias gtv='git tag --list'
alias gts='git tag --sign'

alias  gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'

alias    gst='git stash list'
alias   gsta='git stash apply'
alias   gstc='git stash clear'
alias   gstd='git stash drop'
alias   gstl='git stash list'
alias   gstp='git stash pop'
alias  gstai='git stash push --include-untracked'

alias  gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsn='git bisect new'
alias gbso='git bisect old'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias   gmb='git merge-base'
alias  gmbm='git merge-base $(git_main_branch)'
alias  gmbh='git merge-base $(git_main_branch) HEAD'
alias gmbom='git merge-base origin/$(git_main_branch)'

alias  gmt='git mergetool'
alias  grp='git remote prune'
alias grev='git rev-parse --abbrev-ref HEAD'
alias  gyc="git rev-parse HEAD | tr -d '\n' | pbcopy"

alias ts='tig status'
alias ta='tig --all'

alias lg='lazygit'
