#!/bin/bash
# Session dots - shows current session as filled (●), others as empty (○)
current="$1"
tmux list-sessions -F "#{?#{==:#{session_name},$current},●,○}" 2>/dev/null | tr -d '\n'
