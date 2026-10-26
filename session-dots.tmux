#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

get_tmux_option() {
    local option=$1
    local default_value=$2
    local option_value
    option_value=$(tmux show-option -gqv "$option")
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
    local dot_color active_color active inactive bell_enabled bell show_number show_name separator
    dot_color=$(get_tmux_option "@session-dots-color" "#f5c2e7")
    active_color=$(get_tmux_option "@session-dots-active-color" "$dot_color")
    active=$(get_tmux_option "@session-dots-active" "●")
    inactive=$(get_tmux_option "@session-dots-inactive" "○")
    bell_enabled=$(get_tmux_option "@session-dots-bell-enabled" "false")
    bell=$(get_tmux_option "@session-dots-bell" "◉")
    show_number=$(get_tmux_option "@session-dots-show-number" "false")
    show_name=$(get_tmux_option "@session-dots-show-name" "false")
    separator=$(get_tmux_option "@session-dots-separator" "")
    local placeholder="\#{session_dots}"
    local bell_arg=""
    [ "$bell_enabled" = "true" ] && bell_arg="$bell"
    # Colors go inside #(...), whose command tmux format-expands first: escape '#'
    # so hex values like "#F5c2e7" aren't read as aliases (#F = window flags)
    local color_arg="${dot_color//#/##}" active_color_arg="${active_color//#/##}"
    local script="#[fg=$dot_color]#($CURRENT_DIR/scripts/session-dots.sh '#S' '$active' '$inactive' '$bell_arg' '$show_number' '$show_name' '$separator' '$active_color_arg' '$color_arg')#[default]"
    all_interpolated=${all_interpolated//$placeholder/$script}
    echo "$all_interpolated"
}

update_tmux_option() {
    local option="$1"
    local option_value
    local new_option_value
    option_value="$(get_tmux_option "$option")"
    new_option_value="$(do_interpolation "$option_value")"
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
