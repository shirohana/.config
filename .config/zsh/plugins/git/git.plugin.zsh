function git_copy_current_branch() {
  echo -n "$(git_current_branch | tr -d '\n')" | pbcopy
  echo "Copied '$(git_current_branch)'" >&2
}


alias  grt='cd "$(git rev-parse --show-toplevel || echo .)"'

alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias  gds='git diff --staged'
alias  gdw='git diff --word-diff'

alias  gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gms="git merge --squash"

alias  gp='git push'
alias gpd='git push --dry-run'

alias  grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'

alias  grbm='git rebase $(git_main_branch)'
alias grbom='git rebase origin/$(git_main_branch)'

alias  grbd='git rebase $(git_develop_branch)'
alias grbod='git rebase origin/$(git_develop_branch)'

alias    gst='git stash'
alias gstall='git stash --all'
alias   gsta='git stash apply'
alias   gstc='git stash clear'
alias   gstd='git stash drop'
alias   gstl='git stash list'
alias   gstp='git stash pop'

alias gsi='git submodule init'
alias gsu='git submodule update'

alias gts='git tag --sign'

alias    ga='git add'
alias   gau='git add --update'
alias gcanm='git add . && gcnm'

alias  gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsn='git bisect new'
alias gbso='git bisect old'
alias gbsr='git bisect reset'
alias gbss='git bisect start'

alias   gb='git branch'
alias  gba='git branch --all'
alias  gbd='git branch --delete'
alias  gbD='git branch --delete --force'
alias  gbf='git branch -f'
alias  gbm='git branch --move'
alias  gms='git branch --merged | grep -v "^\*" | grep -v $(git_main_branch)'
alias gccb='git_copy_current_branch'

alias   gco='git checkout'
alias   gcb='git checkout -b'
alias   gdh='git checkout HEAD --detach'
alias   gcd='git checkout $(git_develop_branch)'
alias   gcm='git checkout $(git_main_branch)'
alias gcoom='git checkout origin/$(git_main_branch)'

alias    gc='git commit --verbose'
alias   gc!='git commit --verbose --amend'
alias   gca='git commit --verbose --all'
alias  gca!='git commit --verbose --all --amend'
alias   gcn='git commit --verbose --no-verify'
alias  gcn!='git commit --verbose --no-verify --amend'
alias gcnn!='git commit --no-edit --no-verify --amend --allow-empty'
alias  gcnm="git commit --no-verify -m \"\$(TZ='Asia/Taipei' date +'%Y-%m-%d %H:%M:%S') ->\$(git diff --cached --shortstat)\""
alias   gcs='git commit --verbose --gpg-sign'
alias  gwip="git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]""

alias  g='git status'
alias gs='git status'

alias     gl='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)"'
alias    gla='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias     gz='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias    glp='git log --abbrev-commit --decorate --date=relative --format=format:"%C(yellow)%h%C(reset) %C(bold green)%as%C(reset) - %C(dim white)%s%C(reset) %C(reset)%C(bold yellow)%d%C(reset)" --first-parent'
alias  glpom='git log --abbrev-commit --decorate --date=relative --format=format:"%C(yellow)%h%C(reset) %C(bold green)%as%C(reset) - %C(dim white)%s%C(reset) %C(reset)%C(bold yellow)%d%C(reset)" --first-parent origin/$(git_main_branch)'
alias    gmb='git merge-base'
alias   gmbm='git merge-base $(git_main_branch)'
alias   gmbh='git merge-base $(git_main_branch) HEAD'
alias  gmbom='git merge-base origin/$(git_main_branch)'
# alias    gmt='git mergetool --no-prompt'
alias    gmt='git mergetool'
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
alias   gbfd='git branch -f $(git_develop_branch) origin/$(git_develop_branch)'
alias   grhb='git reset --soft HEAD~'
alias  gbonm='git for-each-ref --format="%(refname:short), %(authorname), %(committerdate:relative), %(contents:subject)" --sort=-committerdate refs/remotes/ --no-merged | column -ts,'
alias    gbr='git branch --remote'
alias  gboum='git for-each-ref --format="%(committerdate:relative) | %(authorname) | %(refname:short) | %(contents:subject)" --sort=-committerdate refs/remotes/ --no-merged'
alias   gbnm='git branch --no-merged'
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

alias gwl='git worktree list'
alias gwa='git worktree add'
alias gwd='git worktree remove'

alias lg='lazygit'
