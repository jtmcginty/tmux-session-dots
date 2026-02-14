# tmux-session-dots

Visual session indicator for tmux status bar. Shows all sessions as dots (●○○) with the current session highlighted.

![Demo](https://via.placeholder.com/600x100/191724/f5c2e7?text=●○○○)

## Why?

If you use multiple tmux sessions and frequently switch between them (e.g., with `Alt+[` and `Alt+]`), this gives you instant visual feedback about:
- How many sessions you have
- Which session you're currently in
- Session state at a glance

## Installation

### Via TPM (recommended)

Add to your `~/.tmux.conf`:

```bash
set -g @plugin 'jtmcginty/tmux-session-dots'
```

Press `prefix + I` to install.

### Manual

```bash
git clone https://github.com/jtmcginty/tmux-session-dots ~/tmux-session-dots
```

Add to your `~/.tmux.conf`:

```bash
run-shell ~/tmux-session-dots/session-dots.tmux
```

## Configuration

### Color

Default is Catppuccin pink (`#f5c2e7`). Customize with:

```bash
set -g @session-dots-color "#89b4fa"  # Catppuccin blue
```

### Separator

Default is ` | `. Customize with:

```bash
set -g @session-dots-separator "  "  # Just spaces
```

### Manual placement

If you want full control over placement in your status bar, don't use the plugin loader. Instead, directly call the script:

```bash
set -g status-right "#[fg=#f5c2e7]#(~/tmux-session-dots/scripts/session-dots.sh) | %H:%M"
```

## How it works

- `●` = Current/attached session
- `○` = Other sessions
- Uses 0.5s caching for performance
- Updates automatically with tmux status refresh

## Performance

The script uses caching to avoid running `tmux list-sessions` on every status bar refresh. This keeps it snappy even with frequent updates.

## License

MIT
