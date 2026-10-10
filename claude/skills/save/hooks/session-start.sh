#!/bin/bash
# save — SessionStart hook
# 1) Snapshots every worktree HEAD of the launch repo (baseline for stop.sh's
#    "+N commits" enrichment). Written once per session so resume keeps it.
# 2) Injects `saves inject <cwd>` verbatim — run that yourself to see exactly
#    what a session launched in a folder receives.
# Requires: jq. macOS /bin/bash (3.2) compatible. No machine-specific paths.
set -u

SAVES="$(cd "$(dirname "$0")/../bin" && pwd)/saves"
SAVES_DIR="${SAVES_DIR:-$HOME/.claude/saves}"; export SAVES_DIR
HEAD_DIR="$SAVES_DIR/.heads"
mkdir -p "$SAVES_DIR" "$HEAD_DIR"

input=$(cat)
session_id=$(printf '%s' "$input" | jq -r '.session_id // empty')
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty')

if [ -n "$session_id" ] && [ ! -f "$HEAD_DIR/$session_id" ]; then
  git -C "$cwd" worktree list --porcelain 2>/dev/null \
    | awk '/^worktree /{p=substr($0,10)} /^HEAD /{print p "\t" substr($0,6)}' \
    > "$HEAD_DIR/$session_id" || true
fi

# opportunistic cleanup of old scratch entries
find "$HEAD_DIR" -type f -mtime +7 -delete 2>/dev/null || true

view=$(bash "$SAVES" inject "${cwd:-$PWD}")
[ -n "$view" ] || exit 0
jq -n --arg ctx "$view" '{hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: $ctx}}'
exit 0
