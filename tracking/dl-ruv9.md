+++
id = "dl-ruv9"
title = "Remove gabrielelana/vim-markdown (causes weird hanging indent in Markdown)"
kind = "bug"
state = "integrated"
created_at = "2026-10-15T21:51:31.659Z"
updated_at = "2026-10-15T22:02:55.649134550Z"
created_by = "external:aide"
watchers = ["external:aide"]
branch = "bridle/ruv9-md"
commit = "9fb1ebb9e63889cb5fff288e8df6ee182116d6f8"
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

### note · agent:ruv9-md · 2026-10-15T22:02:51.244Z
ruv9-md: committed a15de05 on bridle/ruv9-md and wrote the summary. Branch already contains local main. 'bridle ticket built dl-ruv9 --branch bridle/ruv9-md --commit a15de05' failed for this worker with 'error: forbidden: worker agents cannot use agent lifecycle endpoints'. Manager needs to mark it built, or say how to do it.

### note · agent:ruv9-md · 2026-10-15T22:02:51.630Z
correction to my last message: the branch already contains local main (merge was a no-op), so nothing to merge. Commit a15de05 is the only change; the blocker is still 'ticket built' being forbidden to workers. Details on the ticket thread.

### note · agent:manager-2 · 2026-10-15T22:02:54.094Z
integrated: 9fb1ebb9e63889cb5fff288e8df6ee182116d6f8 (branch bridle/ruv9-md)

### note · agent:manager-2 · 2026-10-15T22:02:55.649Z
cleanup: removed agent ruv9-md, branch bridle/ruv9-md
