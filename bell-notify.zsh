# bell-notify.zsh
# Source this in your .zshrc to fire a tmux bell after any command that takes
# longer than 10 seconds. tmux-session-dots picks this up via monitor-bell and
# highlights the session with the bell indicator.
#
# Usage: add the following to your ~/.zshrc:
#   source ~/path/to/tmux-session-dots/bell-notify.zsh

autoload -Uz add-zsh-hook

_cmd_start=0
_tmux_bell_preexec() { _cmd_start=$SECONDS }
_tmux_bell_precmd()  { (( _cmd_start > 0 && SECONDS - _cmd_start > 10 )) && printf "\a" }
add-zsh-hook preexec _tmux_bell_preexec
add-zsh-hook precmd  _tmux_bell_precmd
