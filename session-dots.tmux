#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get user's color preference or use default
dot_color=$(tmux show-option -gqv "@session-dots-color")
dot_color=${dot_color:-"#f5c2e7"}  # Default Catppuccin pink

# Get separator preference or use default
separator=$(tmux show-option -gqv "@session-dots-separator")
separator=${separator:-" | "}

# Add hook for instant updates on session change
tmux set-hook -g client-session-changed 'refresh-client -S'

# Interpolate the dots into status-right (pass current session as argument)
tmux set-option -gaq status-right "#[fg=$dot_color]#($CURRENT_DIR/scripts/session-dots.sh '#S')#[default]$separator"
