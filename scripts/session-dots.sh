#!/bin/bash
# Fast session dots with caching

CACHE="/tmp/tmux-session-dots-$$"
CACHE_TIME=0.5

if [ -f "$CACHE" ] && [ $(echo "$(date +%s.%N) - $(stat -f %m "$CACHE") < $CACHE_TIME" | bc) -eq 1 ]; then
    cat "$CACHE"
else
    tmux list-sessions -F '#{?session_attached,●,○}' 2>/dev/null | tr -d '\n' > "$CACHE"
    cat "$CACHE"
fi
