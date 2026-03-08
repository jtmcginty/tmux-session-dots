#!/bin/bash
# Session dots - shows current session as active symbol, others as inactive symbol
current="$1"
active="${2:-●}"
inactive="${3:-○}"
bell="${4:-}"

if [ -n "$bell" ]; then
    bell_sessions=$(tmux list-windows -a -F "#{session_name} #{window_bell_flag}" 2>/dev/null | awk '$2 == 1 {print $1}')
    tmux list-sessions -F "#{session_name}" 2>/dev/null | while IFS= read -r session; do
        if [ "$session" = "$current" ]; then
            printf '%s' "$active"
        elif echo "$bell_sessions" | grep -qx "$session"; then
            printf '%s' "$bell"
        else
            printf '%s' "$inactive"
        fi
    done
else
    tmux list-sessions -F "#{session_name}" 2>/dev/null | awk -v cur="$current" -v a="$active" -v i="$inactive" '{print ($0 == cur) ? a : i}' | tr -d '\n'
fi
