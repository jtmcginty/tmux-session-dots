# Security Policy

## Scope

tmux-session-dots is a small shell plugin. The primary security considerations are:

- Shell injection via tmux session names passed to `session-dots.sh`
- Unintended execution of arbitrary commands through plugin initialization

## Reporting a vulnerability

Please **do not** open a public issue for security vulnerabilities.

Report them privately via [GitHub's private vulnerability reporting](https://github.com/jtmcginty/tmux-session-dots/security/advisories/new).

Include:
- A description of the vulnerability
- Steps to reproduce
- Potential impact

You can expect a response within 7 days.
