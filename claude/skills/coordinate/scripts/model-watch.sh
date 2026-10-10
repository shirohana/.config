#!/usr/bin/env bash
# Token spend per subagent, per model, from Claude Code's subagent transcripts.
# Usage: model-watch.sh [session-dir|jsonl ...]
#   no args → every subagents/*.jsonl under the project dir of the current cwd
#   session-dir → <dir>/subagents/*.jsonl
# Billed input = input + cache_creation + cache_read per message; one message = one message.id.
# The transcript logs output_tokens at stream start (single digits), so `out~` is an estimate:
# total content characters (text, tool inputs, thinking summaries) / 4.
set -euo pipefail
command -v jq >/dev/null || { echo "jq required" >&2; exit 1; }

files=()
if [ $# -eq 0 ]; then
  proj="$HOME/.claude/projects/$(pwd | sed 's#/#-#g')"
  while IFS= read -r f; do files+=("$f"); done < <(find "$proj" -path '*/subagents/agent-*.jsonl' 2>/dev/null | sort)
else
  for a in "$@"; do
    if [ -d "$a" ]; then while IFS= read -r f; do files+=("$f"); done < <(find "$a" -path '*subagents/agent-*.jsonl' | sort)
    else files+=("$a"); fi
  done
fi
[ ${#files[@]} -gt 0 ] || { echo "no subagent transcripts found" >&2; exit 1; }

printf '%-18s %-18s %5s %10s %10s %8s  %s\n' agent model msgs input cache_rd 'out~' brief
for f in "${files[@]}"; do
  id=$(basename "$f" .jsonl | sed 's/^agent-//')
  jq -r --arg id "$id" '
    [inputs] as $all
    | ($all | map(select(.type=="user")) | first | .message.content
       | if type=="string" then . else (map(select(.type=="text")|.text)|join(" ")) end
       | gsub("\\s+";" ") | .[0:50]) as $brief
    | $all | map(select(.type=="assistant" and .message.usage != null))
    | group_by(.message.model)[]
    | .[0].message.model as $m
    | (group_by(.message.id) | map(.[0])) as $msgs
    | (map(.message.content|tostring|length)|add / 4 | floor) as $out
    | [$id, $m, ($msgs|length),
       ($msgs|map(.message.usage.input_tokens + .message.usage.cache_creation_input_tokens + .message.usage.cache_read_input_tokens)|add),
       ($msgs|map(.message.usage.cache_read_input_tokens)|add),
       $out, $brief]
    | @tsv' -n "$f" | awk -F'\t' '{printf "%-18s %-18s %5s %10s %10s %8s  %s\n",$1,$2,$3,$4,$5,$6,$7}'
done
