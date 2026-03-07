#!/bin/bash
# Session dots - shows current session as active symbol, others as inactive symbol
current="$1"
active="${2:-●}"
inactive="${3:-○}"
tmux list-sessions -F "#{session_name}" 2>/dev/null | awk -v cur="$current" -v a="$active" -v i="$inactive" '{print ($0 == cur) ? a : i}' | tr -d '\n'
