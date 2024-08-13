# Source: https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/git.zsh

# The git prompt's git commands are read-only and should not interfere with
# other processes. This environment variable is equivalent to running with `git
# --no-optional-locks`, but falls back gracefully for older versions of git.
# See git(1) for and git-status(1) for a description of that flag.
#
# We wrap in a local function instead of exporting the variable directly in
# order to avoid interfering with manually-run git commands by the user.
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

function git_current_branch() {
  local ref
  ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
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

# function gbdo() {
#   git branch -d "$@";
#   git push origin ":$@";
# }

# function gbl() {
#   git branch --list "$1" | sed -e 's/^[* ]*//' | sort
# }

# function git_remove_all_merged_local_branches() {
#   git branch --merged | grep -v "^\*" | grep -v $(git_main_branch) | xargs git branch -d
# }
