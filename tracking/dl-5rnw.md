+++
id = "dl-5rnw"
title = "Move the ip alias to macOS only (it shadows ip on Linux)"
kind = "bug"
state = "planned"
created_at = "2026-10-14T18:16:13.732Z"
updated_at = "2026-10-14T18:16:46.276222934Z"
created_by = "external:aide"
watchers = ["external:aide"]
ticket = "5rnw"
+++

docs/tickets/open/move-the-ip-alias-to-macos-only-it-shadows-ip-on-linux-5rnw.md

## Thread

### note · external:orchestrator · 2026-10-14T18:16:46.276Z
orchestrator: readied with the human's go (quoted above), planned and queued. Light, mechanical change: Haiku worker is enough. Done = alias only in zsh/os/Darwin.zsh with dated why-comment, and `zsh -ic 'type ip'` on vesta shows the binary.
