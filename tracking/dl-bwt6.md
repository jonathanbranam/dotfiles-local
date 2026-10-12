+++
id = "dl-bwt6"
title = "Rename host-nuc to host-vesta (the NUC is now vesta)"
kind = "chore"
state = "integrated"
created_at = "2026-10-12T02:53:44.901Z"
updated_at = "2026-10-12T03:00:32.109253593Z"
created_by = "external:orchestrator"
watchers = ["external:orchestrator"]
size = "S"
branch = "host-vesta"
commit = "1cdf09f903646368a6250de318f014a357484797"
summary = "Renamed host-nuc/ to host-vesta/ (the NUC is now vesta): rcrc has HOSTNAME=vesta, CLAUDE.md and README mentions updated; aide's commit 31e3f5b. After landing, live links into host-nuc/ break until ~/.rcrc is re-pointed on vesta: RCRC=/srv/shared/work/dotfiles-work/dotfiles-local/host-vesta/rcrc rcup -B vesta."
+++

The human, via aide (m-0078), 2026-10-12: "yes, let me restart the daemons first, then this needs done." Then (m-0081) the human asked aide to start it locally.

The NUC's hostname is now `vesta`. ~/.rcrc still pins HOSTNAME="nuc", so host-nuc/ links still resolve; this makes the name match.

ALREADY DONE by aide (don't redo): branch `host-vesta`, commit 31e3f5b, worktree /srv/shared/work/dotfiles-work/aide-host-vesta, not pushed, main untouched. It holds the `git mv host-nuc host-vesta`, HOSTNAME="vesta" in rcrc, and the CLAUDE.md/README mentions. `lsrc -B vesta` dry run: rcrc, vimrc.host, tmux.conf.host and local/bin/bridle-update all resolve into host-vesta/.

Remaining (do 2 and 3 back to back: the merge breaks live links until ~/.rcrc is re-pointed):
1. Review 31e3f5b (`grep -rn host-nuc` empty apart from history).
2. Merge host-vesta into main in the live checkout and push.
3. On vesta: re-point ~/.rcrc to host-vesta/rcrc and re-run the README bootstrap (`RCRC=<clone>/host-vesta/rcrc rcup -B vesta`).
4. Verify ~/.vimrc.host, ~/.tmux.conf.host, ~/.local/bin/bridle-update resolve into host-vesta/, and no dangling links into host-nuc/ remain (`find ~ -maxdepth 3 -xtype l`).
5. Remove the aide-host-vesta worktree and branch once merged.

Model: haiku (mechanical). Out of scope: other hosts' folders; bridle config naming the host.

## Thread

### note · agent:manager-1 · 2026-10-12T02:54:15.349Z
integrated: 1cdf09f903646368a6250de318f014a357484797 (branch host-vesta)

### note · agent:manager-1 · 2026-10-12T02:54:15.354Z
cleanup: removed nothing; failed: branch host-vesta: git ["branch", "-D", "host-vesta"] failed: error: cannot delete branch 'host-vesta' used by worktree at '/srv/shared/work/dotfiles-work/aide-host-vesta'

### note · external:orchestrator · 2026-10-12T03:00:32.109Z
orchestrator (human-approved cutover, step 3-4 of the brief): done on vesta.
- Removed the 4 dangling links into host-nuc/, ran `RCRC=/srv/shared/work/dotfiles-work/dotfiles-local/host-vesta/rcrc rcup -v -B vesta`.
- ~/.rcrc, ~/.vimrc.host, ~/.tmux.conf.host, ~/.local/bin/bridle-update now point into host-vesta/. `find ~ -maxdepth 3 -xtype l` is empty; `lsrc | grep host-nuc` is empty.
- Side effect: rcup's post-up hook ran vim-plug PlugClean!, which removed ~/.vim/bundle/vim-mkdir (intended: UnPlug'd 2026-10-09) and ~/.vim/bundle/black (still declared; its checkout had diverged from origin/stable, 1 ahead 8 behind). Reinstalled black with PlugInstall; now at 258e7db, clean on stable.
manager-1: you can remove the aide-host-vesta worktree and branch now.
