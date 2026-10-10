#!/bin/bash
# save — Stop hook: harvest recap(path)/detail(path) lines from the final
# assistant message and write them through ../bin/saves. Writes NOTHING unless
# the message contains recap() lines — saving is always explicit via /save.
# Retiring is NOT harvested: the agent (or you) runs `saves retire` directly.
# Requires: jq. macOS /bin/bash (3.2) compatible. No machine-specific paths.
set -u

SAVES="$(cd "$(dirname "$0")/../bin" && pwd)/saves"
SAVES_DIR="${SAVES_DIR:-$HOME/.claude/saves}"; export SAVES_DIR
HEAD_DIR="$SAVES_DIR/.heads"
TAB=$(printf '\t')

input=$(cat)
session_id=$(printf '%s' "$input" | jq -r '.session_id // empty')
last_msg=$(printf '%s' "$input" | jq -r '.last_assistant_message // empty')
[ -n "$last_msg" ] || exit 0
case "$last_msg" in *"recap("*"):"*) ;; *) exit 0 ;; esac

# session-wide drop-safety verdict — judged from the safe-stop LINE only,
# never the whole message (prose mentioning "unsafe" must not flip the flag)
flag="?"
ss_line=$(printf '%s\n' "$last_msg" | grep -iE 'safe to drop|not safe|unsafe' \
  | grep -vE '^(recap|detail)\(' | tail -1)
if [ -n "$ss_line" ]; then
  if printf '%s' "$ss_line" | grep -qiE 'not safe|unsafe'; then flag="unsafe"
  elif printf '%s' "$ss_line" | grep -qi 'safe to drop'; then flag="safe"; fi
fi

snapshot="$HEAD_DIR/$session_id"

# verb_text <verb> <raw-path> — the text after "<verb>(<raw-path>):", trimmed
verb_text() {
  printf '%s\n' "$last_msg" | grep -F "$1($2):" | head -1 \
    | sed "s/^$1(.*):[[:space:]]*//"
}

# commits made this session in this worktree, vs the SessionStart snapshot
commits_prefix() {
  local path="$1" base head_now c
  [ -f "$snapshot" ] || return 0
  base=$(grep -F "$path$TAB" "$snapshot" 2>/dev/null | head -1 | cut -f2)
  head_now=$(git -C "$path" rev-parse HEAD 2>/dev/null || true)
  [ -n "$base" ] && [ -n "$head_now" ] && [ "$base" != "$head_now" ] || return 0
  c=$(git -C "$path" rev-list --count "$base..$head_now" 2>/dev/null || true)
  [ -n "$c" ] && [ "$c" != "0" ] && printf '+%s commits · ' "$c"
}

printf '%s\n' "$last_msg" | while IFS= read -r line; do
  case "$line" in "recap("*"):"*) ;; *) continue ;; esac
  raw="${line#recap(}"; raw="${raw%%):*}"
  purpose="${line#*):}"; purpose="${purpose#"${purpose%%[![:space:]]*}"}"
  [ -n "$raw" ] && [ -n "$purpose" ] || continue
  detail=$(verb_text detail "$raw")

  path="$raw"; case "$path" in "~"*) path="$HOME${path#\~}" ;; esac
  top=$(git -C "$path" rev-parse --show-toplevel 2>/dev/null || true)
  [ -n "$top" ] && path="$top"

  bash "$SAVES" add "$path" "$purpose" "$(commits_prefix "$path")$detail" --flag "$flag" >/dev/null
done
exit 0
