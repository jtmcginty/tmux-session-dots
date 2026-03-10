# tmux-session-dots

Visual session indicator for your tmux status bar. Shows all sessions as symbols with the current one highlighted — defaults to dots (`●○○`) and fully customizable.

![Demo](demo.gif)

## Why?

If you use multiple tmux sessions and frequently switch between them (e.g., with `Alt+[` and `Alt+]`), this gives you instant visual feedback about:
- How many sessions you have
- Which session you're currently in
- Session state at a glance

## Symbols

Choose any characters for the active and inactive states:

| Active | Inactive | Bell | Preview | Preview (with bell) |
|--------|----------|------|---------|---------------------|
| `●` | `○` | `◉` | `○●○○` (default) | `●◉○○` |
| `•` | `·` | `✦` | `·•··` ⭐ | `•··✦` |
| `■` | `□` | `▣` | `□□■□` | `■▣□□` |
| `★` | `☆` | `✦` | `☆★☆☆` | `★✦☆☆` |
| `◆` | `◇` | `◈` | `◇◇◆◇` | `◆◈◇◇` |
| 🌕 | 🌑 | 🌙 | `🌕🌑🌑🌑` `🌑🌕🌑🌑` `🌑🌑🌕🌑` `🌑🌑🌑🌕` | `🌕🌙🌑🌑` |
| 💎 | 🪨 | 🔔 | `💎🪨🪨🪨` `🪨💎🪨🪨` `🪨🪨💎🪨` `🪨🪨🪨💎` | `💎🔔🪨🪨` |
| 🧿 | `·` | 🔮 | `🧿···` `·🧿··` `··🧿·` `···🧿` | `🧿🔮··` |
| 🌩️ | ☁️ | ⛈️ | `🌩️☁️☁️☁️` `☁️🌩️☁️☁️` `☁️☁️🌩️☁️` `☁️☁️☁️🌩️` | `🌩️⛈️☁️☁️` |
| 🔥 | 🪵 | 💥 | `🔥🪵🪵🪵` `🪵🔥🪵🪵` `🪵🪵🔥🪵` `🪵🪵🪵🔥` | `🔥💥🪵🪵` |
| 👄 | 👁️ | 👀 | `👄👁️👁️👁️` `👁️👄👁️👁️` `👁️👁️👄👁️` `👁️👁️👁️👄` | `👄👀👁️👁️` |
| `(*)` | `( )` | `(!)` | `(*)( )( )( )` `( )(*)( )( )` `( )( )(*)( )` `( )( )( )(*)` | `(*)(!)( )( )` |

⭐ author's preferred setup

![moon](assets/preview-moon.png)
![dots](assets/preview-dots.png)
![dots-small](assets/preview-dots-small.png)
![blocks](assets/preview-blocks.png)
![arrows](assets/preview-arrows.png)
![stars](assets/preview-stars.png)
![diamonds](assets/preview-diamonds.png)
![bars](assets/preview-bars.png)

Want to try a combination before committing? Use the included preview script:

```bash
./scripts/preview.sh "▶" "▷"
```

## Installation

### Via TPM (recommended)

Add to your `~/.tmux.conf`:

```bash
set -g @plugin 'jtmcginty/tmux-session-dots'
```

Then add `#{session_dots}` wherever you want in your status bar:

```bash
set -g status-right "#{session_dots} | %H:%M %p"
```

Press `prefix + I` to install.

### Manual

```bash
git clone https://github.com/jtmcginty/tmux-session-dots ~/tmux-session-dots
```

Add to your `~/.tmux.conf`:

```bash
run-shell ~/tmux-session-dots/session-dots.tmux
set -g status-right "#{session_dots} | %H:%M"
```

## Usage

Add `#{session_dots}` anywhere in your `status-right` or `status-left`:

```bash
# At the beginning of status-right
set -g status-right "#{session_dots} | %H:%M %p"

# In the middle
set -g status-right "%H:%M | #{session_dots} | #H"

# On the left side
set -g status-left "#{session_dots} "
```

The plugin handles all formatting — you just add separators and spacing as you prefer.

## Configuration

### Symbols

```bash
set -g @session-dots-active "▶"
set -g @session-dots-inactive "▷"
```

### Color

Default is Catppuccin pink (`#f5c2e7`). Customize with:

```bash
set -g @session-dots-color "#89b4fa"  # Catppuccin blue
```

### Bell indicator (optional)

Disabled by default. Highlights sessions where a bell has fired in any window — most useful when paired with a shell hook that fires a bell after long-running commands complete.

```bash
set -g @session-dots-bell-enabled "true"
set -g @session-dots-bell "◉"  # default
```

With bell enabled, three states are shown: active (`●`), bell (`◉`), inactive (`○`). Bell takes priority over inactive but never overrides the current session indicator.

#### Automatic bell on long-running commands (recommended)

The plugin ships with `bell-notify.zsh` — a small zsh snippet that fires a terminal bell whenever a command takes longer than 10 seconds. **zsh only** — bash users can achieve the same with [`bash-preexec`](https://github.com/rcaloras/bash-preexec).

Source it in your `~/.zshrc`:

```zsh
# ~/.zshrc
source ~/path/to/tmux-session-dots/bell-notify.zsh
```

Or if you installed via TPM:

```zsh
source ~/.tmux/plugins/tmux-session-dots/bell-notify.zsh
```

**The full workflow:**

1. You kick off a long build or test run in one session
2. You switch to another session and keep working
3. When the command finishes, the bell fires — the dot for that session switches to `◉`
4. You see it in the status bar and switch back when you're ready

No polling, no blocking — you get a passive visual cue the moment the work is done.

tmux's `monitor-bell` is on by default, so no extra tmux config is needed. You can also emit a bell manually with `printf "\a"` from any script.

## Recommended: Quick Session Switching

This plugin pairs well with keybindings for cycling through sessions. Add these to your `~/.tmux.conf` to switch sessions with `Option + [` and `Option + ]`:

```bash
bind-key -n M-[ switch-client -p
bind-key -n M-] switch-client -n
```

The indicator updates instantly as you switch.

## How it works

Uses tmux's `client-session-changed` hook to update the status bar the moment you switch sessions — no polling, no delay. Correctly identifies the current session rather than just the attached one.

## License

MIT

## Thanks & Support

Loving the dots?
If this plugin makes your tmux life better, please give it a ⭐ on GitHub — it helps more people discover it!

Happy session switching!
