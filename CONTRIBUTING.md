# Contributing

Thanks for your interest in tmux-session-dots!

## Development setup

1. Install [TPM](https://github.com/tmux-plugins/tpm)
2. Clone this repo into `~/.tmux/plugins/tmux-session-dots`
3. Add to `~/.tmux.conf`:
   ```
   set -g @plugin 'jtmcginty/tmux-session-dots'
   ```
4. Reload tmux: `tmux source ~/.tmux.conf`

## Making changes

- Edit `scripts/session-dots.sh` for dot rendering logic
- Edit `session-dots.tmux` for plugin initialization and interpolation

Test changes by sourcing the plugin directly:
```sh
bash session-dots.tmux
```

## Submitting a pull request

1. Fork the repo and create a branch from `main`
2. Make your changes and test locally
3. Commit using [Conventional Commits](https://www.conventionalcommits.org/):
   ```sh
   cz commit   # interactive prompt (requires commitizen)
   # or manually: git commit -m "fix: correct dot rendering for single session"
   ```
4. Open a PR — the template will guide you through the description

## Commit types

| Type | When to use |
|------|-------------|
| `feat` | New feature or option |
| `fix` | Bug fix |
| `docs` | Documentation only |
| `chore` | Maintenance, deps, config |
| `refactor` | Code change with no behavior change |
| `perf` | Performance improvement |
