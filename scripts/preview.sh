#!/bin/bash
# Preview session-dots symbols without reloading tmux
# Usage: ./scripts/preview.sh [active] [inactive]
# Examples:
#   ./scripts/preview.sh
#   ./scripts/preview.sh "▶" "–"
#   ./scripts/preview.sh "•" "·"

active="${1:-●}"
inactive="${2:-○}"

# Fake session names to simulate output
sessions=("work" "dotfiles" "music" "notes")

echo "Previewing with: active='$active'  inactive='$inactive'"
echo ""

for current in "${sessions[@]}"; do
    output=""
    for session in "${sessions[@]}"; do
        if [ "$session" = "$current" ]; then
            output+="$active"
        else
            output+="$inactive"
        fi
    done
    echo "  current=$current  →  $output"
done
