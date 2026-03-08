#!/bin/bash
# Preview session-dots symbols without reloading tmux
# Usage: ./scripts/preview.sh [active] [inactive] [bell]
# Examples:
#   ./scripts/preview.sh
#   ./scripts/preview.sh "▶" "–"
#   ./scripts/preview.sh "•" "·"
#   ./scripts/preview.sh "•" "·" "✦"

active="${1:-●}"
inactive="${2:-○}"
bell="${3:-}"

# Fake session names to simulate output
sessions=("work" "dotfiles" "music" "notes")

if [ -n "$bell" ]; then
    echo "Previewing with: active='$active'  inactive='$inactive'  bell='$bell'"
else
    echo "Previewing with: active='$active'  inactive='$inactive'"
fi
echo ""

for current in "${sessions[@]}"; do
    output=""
    for i in "${!sessions[@]}"; do
        session="${sessions[$i]}"
        if [ "$session" = "$current" ]; then
            output+="$active"
        elif [ -n "$bell" ] && [ "$i" = "1" ]; then
            output+="$bell"
        else
            output+="$inactive"
        fi
    done
    echo "  current=$current  →  $output"
done
