#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

get_tmux_option() {
    local option=$1
    local default_value=$2
    local option_value=$(tmux show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

set_tmux_option() {
    local option=$1
    local value=$2
    tmux set-option -gq "$option" "$value"
}

do_interpolation() {
    local all_interpolated="$1"
    local dot_color=$(get_tmux_option "@session-dots-color" "#f5c2e7")
    local placeholder="\#{session_dots}"
    local script="#[fg=$dot_color]#($CURRENT_DIR/scripts/session-dots.sh '#S')#[default]"
    all_interpolated=${all_interpolated//$placeholder/$script}
    echo "$all_interpolated"
}

update_tmux_option() {
    local option="$1"
    local option_value="$(get_tmux_option "$option")"
    local new_option_value="$(do_interpolation "$option_value")"
    set_tmux_option "$option" "$new_option_value"
}

main() {
    # Add hook for instant updates on session change
    tmux set-hook -g client-session-changed 'refresh-client -S'
    
    # Interpolate #{session_dots} in status-right and status-left
    update_tmux_option "status-right"
    update_tmux_option "status-left"
}

main
