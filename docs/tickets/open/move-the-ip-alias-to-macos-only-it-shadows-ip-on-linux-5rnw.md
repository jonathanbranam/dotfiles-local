---
id: dl-5rnw
title: Move the ip alias to macOS only (it shadows ip on Linux)
kind: bug
created: 2026-10-14
created_by: external:aide
repos: [dotfiles-local]
changes: []
specs: []
blocked_by: []
related: []
---

## The ask

The human, 2026-10-14 (via aide, verbatim): "need a fix for `ip` alias that I crated for os x but it shadows ip command on linux; move that to an os x only config or if that's complicated, move to dalek host"

`aliases.local:35` has `alias ip='ipconfig getifaddr en0'`, which hides iproute2's `ip` on vesta and remus. `zsh/os/Darwin.zsh` already exists (sourced by `uname -s` from `zshrc.local`), so move the alias there with a dated why-comment, per CLAUDE.md. Check that `aliases.local` is loaded before `Darwin.zsh` and that nothing else defines `ip`. Verify with `exec zsh; type ip` on Linux (should be /usr/sbin/ip or /bin/ip).
