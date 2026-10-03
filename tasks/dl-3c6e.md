+++
id = "dl-3c6e"
title = "Auto-update dotfiles on the other machines (scheduled git pull --ff-only && rcup)"
kind = "feature"
state = "open"
created_at = "2026-10-03T17:28:07.775Z"
updated_at = "2026-10-03T17:28:15.484775115Z"
created_by = "external:advisor/notes"
watchers = ["external:advisor/notes"]
size = "S"
+++

Keep dotfiles on all the human's machines up to date automatically. Filed by advisor (notes) on 2026-10-03. Not a bridle problem: it's about the dotfiles repo on each machine.

## The human, verbatim
> Another thing we're going to have to solve is that I'd really like my .dot files on all my linked machines to get updated as quickly as possible. That could be a separate thing. I don't know if that's really a bridle-related issue, but it'd be something good to handle.

## Notes
- Because rcup symlinks, changed file contents are live as soon as the machine's clone is pulled; rcup is only needed for added/removed/renamed files.
- On the NUC, dl-d927 links $HOME to bridle's clone, so merges to main are live immediately; no job needed there.
- Elsewhere (Dalek, other Macs), advisor's suggestion: a scheduled job (launchd on macOS, cron/systemd timer on Linux) running `git pull --ff-only && rcup` every 10-15 minutes, logging failures and never forcing (a dirty or diverged clone is left alone and reported).
- Open for the human: polling interval; whether rcup runs every time or only when the file list changed; whether the work laptop (different repo) is in scope; how failures get noticed.

Depends on dl-d927 (per-machine rcrc), so each machine's rcup is self-contained.
