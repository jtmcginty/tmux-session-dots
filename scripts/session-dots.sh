#!/bin/bash
# Session dots - shows current session as active symbol, others as inactive symbol
#
# Usage:
#   session-dots.sh <current> [active] [inactive] [bell] [show_number] [show_name] [separator] \
#                   [active_color] [color]
#
# Options (normally set via session-dots.tmux):
#   show_number     "true"  -> append ":<number>" after the active session's indicator
#                   "all"   -> append ":<number>" after every session's indicator
#   show_name       "true"  -> append ":<name>" after the active session's indicator
#                   "all"   -> append ":<name>" after every session's indicator
#   separator       string placed between session entries (default: none)
#   active_color    color for the active entry; restored to <color> afterwards.
#                   No style codes are emitted when empty or equal to <color>.
#
# Each entry renders as <indicator>:<number>:<name>, e.g. "▶:2:work".
#
# Must stay compatible with bash 3.2 (macOS /bin/bash): no mapfile, no assoc arrays.
current="$1"
active="${2:-●}"
inactive="${3:-○}"
bell="${4:-}"
show_number="${5:-false}"
show_name="${6:-false}"
separator="${7:-}"
active_color="${8:-}"
color="${9:-}"

sessions=()
while IFS= read -r s; do
    sessions+=("$s")
done < <(tmux list-sessions -F "#{session_name}" 2>/dev/null)

# Newline-delimited list of sessions with a bell, padded so `case` can match whole lines
bell_sessions=$'\n'
if [ -n "$bell" ]; then
    bell_sessions+=$(tmux list-windows -a -F "#{session_name} #{window_bell_flag}" 2>/dev/null | awk '$2 == 1 {print $1}')
    bell_sessions+=$'\n'
fi

# $1 = "true"/"all" option value, $2 = 1 if this is the current session
label_enabled() {
    [ "$1" = "all" ] || { [ "$1" = "true" ] && [ "$2" = 1 ]; }
}

output=""
for idx in "${!sessions[@]}"; do
    session="${sessions[$idx]}"
    is_current=0
    [ "$session" = "$current" ] && is_current=1

    if [ "$is_current" = 1 ]; then
        entry="$active"
    else
        entry="$inactive"
        if [ -n "$bell" ]; then
            case "$bell_sessions" in
                *$'\n'"$session"$'\n'*) entry="$bell" ;;
            esac
        fi
    fi

    label_enabled "$show_number" "$is_current" && entry+=":$(( idx + 1 ))"
    label_enabled "$show_name" "$is_current" && entry+=":$session"

    if [ "$is_current" = 1 ] && [ -n "$active_color" ] && [ "$active_color" != "$color" ]; then
        entry="#[fg=$active_color]${entry}#[fg=${color:-default}]"
    fi

    [ "$idx" -gt 0 ] && output+="$separator"
    output+="$entry"
done

printf '%s' "$output"
