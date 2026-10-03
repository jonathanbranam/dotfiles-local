+++
id = "dl-b25b"
title = "Per-machine config via rcm host-<name>/ folders; move meta-notes path out of the existence check"
kind = "feature"
state = "open"
created_at = "2026-10-03T17:27:47.287Z"
updated_at = "2026-10-03T17:27:47.287Z"
created_by = "external:advisor/notes"
watchers = ["external:advisor/notes"]
size = "M"
+++

Per-machine config using rcm's built-in host folders (`host-<hostname>/`). Replaces the "guard on existence" approach for anything that differs between machines. Filed by advisor (notes) on 2026-10-03 from a discussion with the human.

## The human, verbatim
> We need to implement per-machine settings. That's just something we need, not per architecture, but per machine. There's a need now to make a different mapping on the NUC versus Dalek about the path to the locally installed MetaNotes thing.

> I just don't like the existence check. It's hacky and messy and doesn't handle other situations where I want a different config on a different machine. I think we just need to solve the machine-specific config question somehow.

> Host name makes sense. Unfortunately, I want to rename this machine first, but otherwise, yes, host name's probably the right thing to do.

## Design (agreed with the human)
- rcm 1.3.4 (`man rcup`, "DIRECTORY LAYOUT") installs files under `host-<HOSTNAME>/` only on the machine with that name, linked like top-level files: `host-nuc/vimrc.host` becomes `~/.vimrc.host`. rcrc's `HOSTNAME=` pins the name (dl ticket for rcrc does that); `rcup -B <name>` overrides it for one run.
- Each machine's folder holds the same small set of files: `vimrc.host`, `zshrc.host`, `tmux.conf.host` (only the ones that machine needs).
- `vimrc.local`, `zshrc.local` and `tmux.conf.local` each get one line that loads the host file if it exists (vim `filereadable` + `source`, zsh `[[ -f ]] && source`, tmux `source-file -q`). Nothing in the repo calls `hostname`; rcup resolves the machine once.

## Steps
1. Create `host-nuc/` and `host-dalek/`. Machine names: the human plans to rename the NUC first. Use the new name if it's known when this is planned; otherwise `nuc` (current `hostname -s`), and the folder gets renamed later. Confirm Dalek's name with the human (`hostname -s` / `scutil --get LocalHostName` on Dalek).
2. Add the three load lines to vimrc.local, zshrc.local, tmux.conf.local, each with a dated why-comment.
3. Move the meta-notes runtimepath out of vimrc.local's existence-check loop (commit 0909cee) into the host files: NUC `/srv/shared/work/meta-notes-work/meta-notes`, Dalek `~/work/meta-notes-workspace/meta-notes`. Keep the autosave/autoreload settings where they are unless they only make sense with meta-notes loaded.
4. CLAUDE.md "Layout" and the zsh/os rule: replace "No per-machine branches" with the host-folder rule: per-machine differences go in `host-<name>/`; OS differences stay in zsh/os/; existence guards stay fine for "use it if installed" but not for picking between machines.
5. Don't run rcup (human's step). `zsh -n` the zsh files; say in the summary what the human checks after rcup (`ls -l ~/.vimrc.host`, `:set rtp?` shows the right meta-notes path).

## Out of scope
- Moving rcrc into the repo and switching the NUC's live links to bridle's clone (separate ticket).
- Auto-updating other machines (separate ticket).
