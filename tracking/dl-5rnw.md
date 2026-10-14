+++
id = "dl-5rnw"
title = "Move the ip alias to macOS only (it shadows ip on Linux)"
kind = "bug"
state = "integrated"
created_at = "2026-10-14T18:16:13.732Z"
updated_at = "2026-10-14T18:22:15.707551596Z"
created_by = "external:aide"
watchers = ["external:aide"]
branch = "bridle/ip-alias"
commit = "ec976826fbcdb8cc1cf4a0b97de5e94611655de5"
summary = """
Moved `alias ip='ipconfig getifaddr en0'` from aliases.local to zsh/os/Darwin.zsh, with a
comment giving the original 2026-09-23 date and the 2026-10-14 move (dl-5rnw). The alias
no longer shadows iproute2's ip on Linux (vesta, remus).

Load order: zshrc.local sources zsh/os/$(uname -s).zsh before ~/.aliases, which sources
~/.aliases.local, so nothing later could override it. Nothing else in the repo or in
~/dotfiles defines ip.

Check: with the worktree's aliases.local only, `zsh -f -c 'source ./aliases.local; type ip'`
gives /usr/sbin/ip; Linux.zsh does not define it. The symlinks in $HOME point at the main
checkout, so `zsh -ic 'type ip'` on this box still shows the alias until this merges."""
ticket = "5rnw"
+++

docs/tickets/open/move-the-ip-alias-to-macos-only-it-shadows-ip-on-linux-5rnw.md

## Thread

### note · external:orchestrator · 2026-10-14T18:16:46.276Z
orchestrator: readied with the human's go (quoted above), planned and queued. Light, mechanical change: Haiku worker is enough. Done = alias only in zsh/os/Darwin.zsh with dated why-comment, and `zsh -ic 'type ip'` on vesta shows the binary.

### note · agent:ip-alias · 2026-10-14T18:22:07.773Z
done: ip alias moved from aliases.local to zsh/os/Darwin.zsh with dated comment; verified with zsh -f 'source ./aliases.local; type ip' -> /usr/sbin/ip (no just check in this repo, config only); commit 86bf328 on bridle/ip-alias, main merged in (already up to date). NOT marked built: 'bridle ticket built' returned 'forbidden: worker agents cannot use agent lifecycle endpoints', so please mark it built or land it. Note: ~/.aliases.local symlinks to the main checkout, so 'zsh -ic type ip' there still shows the alias until merge.

### note · agent:manager-1 · 2026-10-14T18:22:14.446Z
integrated: ec976826fbcdb8cc1cf4a0b97de5e94611655de5 (branch bridle/ip-alias)

### note · agent:manager-1 · 2026-10-14T18:22:15.707Z
cleanup: removed agent ip-alias, branch bridle/ip-alias
