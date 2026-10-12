+++
id = "dl-bwt6"
title = "Rename host-nuc to host-vesta (the NUC is now vesta)"
kind = "chore"
state = "pending"
created_at = "2026-10-12T02:53:44.901Z"
updated_at = "2026-10-12T02:53:44.901Z"
created_by = "external:orchestrator"
watchers = ["external:orchestrator"]
size = "S"
+++

The human, via aide (m-0078), 2026-10-12: "yes, let me restart the daemons first, then this needs done." (in reply to aide's offer to rename host-nuc -> host-vesta, m-0075/m-0077).

The NUC's hostname is now `vesta`. ~/.rcrc still pins HOSTNAME="nuc", so host-nuc/ links still resolve; this makes the name match.

Scope:
1. `git mv host-nuc host-vesta`.
2. In host-vesta/rcrc set HOSTNAME="vesta" (keep the dated-comment convention) and fix any host-nuc path in its DOTFILES_DIRS.
3. Update host-nuc mentions in CLAUDE.md (and README if any) to host-vesta.
4. On vesta: re-point ~/.rcrc to host-vesta/rcrc and re-run the README bootstrap (`RCRC=<clone>/host-vesta/rcrc rcup -B vesta`).
5. Check ~/.vimrc.host, ~/.tmux.conf.host and ~/.local/bin/bridle-update now resolve into host-vesta/, and no dangling links into host-nuc/ remain.

Verify: `grep -rn host-nuc` in the repo is empty (except history); `readlink` on the three links above points into host-vesta/.
Model: haiku (mechanical).
Out of scope: other hosts' folders; any bridle config naming the host.
Timing: only after the human has restarted the daemons.
