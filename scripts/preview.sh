#!/bin/bash
# Preview session-dots symbols without reloading tmux
# Usage: ./scripts/preview.sh [active] [inactive] [bell]
#                             [--number | --all-numbers] [--name | --all-names] [--separator "<str>"]
# Examples:
#   ./scripts/preview.sh
#   ./scripts/preview.sh "▶" "–"
#   ./scripts/preview.sh "•" "·"
#   ./scripts/preview.sh "•" "·" "✦"
#   ./scripts/preview.sh --all-numbers
#   ./scripts/preview.sh "▶" "▷" "◉" --all-numbers --name --separator " "

active="●"
inactive="○"
bell=""
show_number="false"
show_name="false"
separator=""
positional=0
while [ $# -gt 0 ]; do
    case "$1" in
        --number)      show_number="true" ;;
        --all-numbers) show_number="all" ;;
        --name)        show_name="true" ;;
        --all-names)   show_name="all" ;;
        --separator)   separator="$2"; shift ;;
        *)
            positional=$(( positional + 1 ))
            case "$positional" in
                1) active="$1" ;;
                2) inactive="$1" ;;
                3) bell="$1" ;;
            esac
            ;;
    esac
    shift
done

# Fake tmux so the real renderer runs against simulated sessions;
# the second session ("dotfiles") has a pending bell
tmux() {
    case "$1" in
        list-sessions) printf '%s\n' work dotfiles music notes ;;
        list-windows)  printf '%s\n' "work 0" "dotfiles 1" "music 0" "notes 0" ;;
    esac
}
export -f tmux

echo "Previewing with: active='$active'  inactive='$inactive'  bell='$bell'  number=$show_number  name=$show_name  separator='$separator'"
echo ""

script_dir="$(cd "$(dirname "$0")" && pwd)"
for current in work dotfiles music notes; do
    output=$("$script_dir/session-dots.sh" "$current" "$active" "$inactive" "$bell" "$show_number" "$show_name" "$separator")
    echo "  current=$current  →  $output"
done
