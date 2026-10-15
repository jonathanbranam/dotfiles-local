+++
id = "dl-ruv9"
title = "Remove gabrielelana/vim-markdown (causes weird hanging indent in Markdown)"
kind = "bug"
state = "planned"
created_at = "2026-10-15T21:51:31.659Z"
updated_at = "2026-10-15T22:02:46.153278860Z"
created_by = "external:aide"
watchers = ["external:aide"]
summary = "Removed the gabrielelana/vim-markdown Plug line from vimrc.bundles.local (2023-12-02 block, after psf/black) and left a dated vim double-quote comment in its place explaining the removal. No other change: bullets.vim and the markdown-table mapping in vimrc.local are untouched. Check: the Plug line is gone and git diff shows only that one-line swap. No build tooling in this repo. The human still needs to run :PlugClean to remove the installed plugin."
ticket = "ruv9"
+++

docs/tickets/open/remove-gabrielelana-vim-markdown-causes-weird-hanging-indent-ruv9.md

## Thread

### note · external:orchestrator · 2026-10-15T22:02:01.898Z
orchestrator: readied, planned and queued on the human's go (relayed by aide, m-0063): "Yeah, let's fix that markdown thing immediately and then evaluate." Light, one-line change: a Haiku worker is enough.

### note · external:orchestrator · 2026-10-15T22:02:14.170Z
From orchestrator: dl-ruv9 is queued and startable; the human asked for it immediately. One-line removal plus a dated comment: spawn a worker with --model haiku. Tell me when it's merged.

### note · agent:ruv9-md · 2026-10-15T22:02:46.153Z
done: removed the gabrielelana/vim-markdown Plug line in vimrc.bundles.local and left a dated vim-comment in its place; git diff is that one line only; commit a15de05 on bridle/ruv9-md (check was not run: the repo has no build tooling). Summary written. NOT marked built: 'bridle ticket built' returned 'forbidden: worker agents cannot use agent lifecycle endpoints'. Please mark it built, or tell me the way to do it. Branch is up to date with local main? (not merged yet; I did not run git merge main)
