#!/usr/bin/env zsh
# Benchmark zsh startup time

echo "=== Zsh Startup Benchmark ==="
echo

# Run 5 times and average
times=()
for i in {1..5}; do
  result=$( { time zsh -i -c 'exit' } 2>&1 | grep 'cpu' | awk '{print $(NF-1)}' )
  times+=($result)
  echo "Run $i: $result seconds"
done

echo
echo "Average startup time: $(printf '%s\n' "${times[@]}" | awk '{sum+=$1} END {print sum/NR}') seconds"
echo
echo "=== Detail Breakdown ==="
echo "Run with: zsh -xv 2>&1 | ts -i '%.s' to see timing per line"
