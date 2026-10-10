#!/usr/bin/env bash
input=$(cat)

dir=$(echo "$input" | jq -r '.workspace.project_dir // .workspace.current_dir // .cwd // ""')
dir_display=$(echo "$dir" | awk -F'/' '{print $(NF-1)"/"$NF}')

model=$(echo "$input" | jq -r '.model.display_name // "" | sub(" context\\)"; ")")')

input_tokens=$(echo "$input" | jq -r '
  .context_window.current_usage
  | if . then
      ((.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0))
    else empty end
')
if [ -n "$input_tokens" ] && [ "$input_tokens" != "0" ]; then
  ctx_k=$(echo "$input_tokens" | awk '{printf "%.1fk", $1/1000}')
  ctx_str="ctx:${ctx_k}"
else
  ctx_str=""
fi

total_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // empty')
total_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // empty')
if [ -n "$total_in" ] && [ -n "$total_out" ]; then
  in_k=$(echo "$total_in" | awk '{printf "%.1fk", $1/1000}')
  out_k=$(echo "$total_out" | awk '{printf "%.1fk", $1/1000}')
  io_str="↑${in_k} ↓${out_k}"
else
  io_str=""
fi

transcript=$(echo "$input" | jq -r '.transcript_path // empty')
last_response_str=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
  last_ts=$(jq -r 'select(.type == "assistant") | .timestamp' "$transcript" 2>/dev/null | tail -1)
  if [ -n "$last_ts" ]; then
    epoch=$(date -j -u -f "%Y-%m-%dT%H:%M:%S" "${last_ts%%.*}" "+%s" 2>/dev/null \
         || date -d "$last_ts" "+%s" 2>/dev/null)
    if [ -n "$epoch" ]; then
      last_response_str="$(date -r "$epoch" "+%H:%M" 2>/dev/null || date -d "@$epoch" "+%H:%M" 2>/dev/null)"
    fi
  fi
fi

five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_resets=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
if [ -n "$five_pct" ]; then
  if [ -n "$five_resets" ]; then
    reset_time=$(date -r "$five_resets" "+%-I%p" 2>/dev/null || date -d "@$five_resets" "+%-I%p" 2>/dev/null)
    five_str=$(printf "5h:%.0f%%:~%s" "$five_pct" "$reset_time")
  else
    five_str=$(printf "5h:%.0f%%" "$five_pct")
  fi
else
  five_str=""
fi

week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
if [ -n "$week_pct" ]; then
  week_str=$(printf "7d:%.0f%%" "$week_pct")
else
  week_str=""
fi


first=1
_print() {
  local color="$1" text="$2"
  if [ "$first" -eq 1 ]; then
    printf "\033[%sm%s\033[0m" "$color" "$text"
    first=0
  else
    printf " \033[%sm%s\033[0m" "$color" "$text"
  fi
}

[ -n "$model" ]             && _print "0;34" "[$model]"
[ -n "$ctx_str" ]           && _print "0;32" "$ctx_str"
[ -n "$io_str" ]    && _print "0;35" "$io_str"
[ -n "$five_str" ]  && _print "0;33" "$five_str"
[ -n "$week_str" ]  && _print "0;33" "$week_str"
[ -n "$last_response_str" ] && _print "0;90" "$last_response_str"
[ -n "$dir_display" ] && _print "0;36" "$dir_display"

echo ""
