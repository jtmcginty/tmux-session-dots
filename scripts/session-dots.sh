#!/bin/bash
# Session dots - shows current session as filled (●), others as empty (○)
current="$1"
tmux list-sessions -F "#{session_name}" 2>/dev/null | awk -v cur="$current" '{print ($0 == cur) ? "●" : "○"}' | tr -d '\n'
