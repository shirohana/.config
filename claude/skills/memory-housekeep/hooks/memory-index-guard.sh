#!/bin/bash
# memory-housekeep — PostToolUse hook (Write|Edit|Bash): keep MEMORY.md a pointer index.
# MEMORY.md is loaded whole into every session with no condition, and the harness
# silently truncates it past its limit — entries past the cut never reach the agent.
# So the index must stay small: one pointer line per memory, never content.
# Exit 2 + stderr = the reason is fed back to the model, which must shorten before
# going on. Requires: jq. macOS /bin/bash (3.2) compatible.
set -u

LINE_MAX=250        # same cap as a /save handoff — one convention
BYTE_MAX=20000     # harness drops past 25 KB / 200 lines; guard at 80% so one session cannot land on the cliff
LINES_MAX=160

input=$(cat)
tool=$(printf '%s' "$input" | jq -r '.tool_name // empty')
paths=""
case "$tool" in
  Write|Edit|MultiEdit)
    p=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')
    case "$p" in */memory/MEMORY.md) paths="$p" ;; esac ;;
  Bash)
    cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')
    paths=$(printf '%s' "$cmd" | grep -oE "[^[:space:]\"'\`;|<>()]*memory/MEMORY\.md" | sort -u) ;;
esac
[ -n "$paths" ] || exit 0

cwd=$(printf '%s' "$input" | jq -r '.cwd // empty')
bad=0
while IFS= read -r f; do
  [ -n "$f" ] || continue
  case "$f" in "~"*) f="$HOME${f#\~}" ;; /*) ;; *) f="$cwd/$f" ;; esac
  [ -f "$f" ] || continue
  bytes=$(wc -c < "$f" | tr -d ' ')
  lines=$(grep -c '' "$f" | tr -d ' ')
  over=$(awk -v m="$LINE_MAX" 'length($0) > m { n++ } END { print n+0 }' "$f")
  longest=$(awk '{ if (length($0) > L) { L = length($0); N = NR } } END { print L+0 " chars at line " N+0 }' "$f")
  if [ "$bytes" -gt "$BYTE_MAX" ] || [ "$lines" -gt "$LINES_MAX" ] || [ "$over" -gt 0 ]; then
    bad=1
    {
      echo "MEMORY.md index guard: $f"
      echo "  $bytes bytes (limit $BYTE_MAX), $lines lines (limit $LINES_MAX), $over lines over $LINE_MAX chars (longest: $longest)."
      echo "  MEMORY.md is a pointer index, loaded whole into every session and silently truncated past the limit."
      echo "  Fix now, before continuing: one line per memory, '- [Title](file.md) — hook' under $LINE_MAX chars;"
      echo "  move the content into the memory file itself. The backlog line is only"
      echo "  '- [Backlog](backlog.md) — N open; top: <one item>' — ticket state lives in backlog.md, never here."
    } >&2
  fi
done <<< "$paths"

[ "$bad" -eq 1 ] && exit 2
exit 0
