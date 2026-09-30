+++
id = "dl-c5fc"
title = "Replace zshrc.branch.local with per-OS zsh config (zsh/os/), vim/tmux OS split"
kind = "feature"
state = "planned"
created_at = "2026-09-30T22:23:14.121Z"
updated_at = "2026-09-30T22:23:33.542961268Z"
size = "M"
+++

Implement the plan in /srv/shared/work/dotfiles-work/OS-SPLIT-PLAN.md (outside the repo; read it first). It replaces zshrc.branch.local, which is Dalek/macOS config loaded on every machine, with per-OS files picked by `uname -s`.

## In scope (plan "Steps" 1-3, 4 without rcup, 5, 7)
1. Create zsh/os/Darwin.zsh and zsh/os/Linux.zsh. They must NOT go under zsh/configs/, because thoughtbot sources everything there.
2. Move zshrc.branch.local's contents out, following the plan's table:
   - Existence-guarded common config goes in zshrc.local.
   - Genuinely macOS-only paths (conda Caskroom, JAVA_HOME, Android SDK, UV_CACHE_DIR=/Volumes/Data/.cache/uv, active again, guarded on /Volumes/Data) go in Darwin.zsh.
   - Delete the dead commented-out blocks (nvm, spark, jdk(), rbenv, pdm, thefuck, mysql-client).
   - Linux.zsh starts nearly empty, with a header comment.
3. In zshrc.local, replace the `~/.zshrc.branch.local` source line with:
       [[ -f ~/.zsh/os/$(uname -s).zsh ]] && source ~/.zsh/os/$(uname -s).zsh
   Keep a single ~/.cargo/env load in common config.
4. `git rm zshrc.branch.local`. Don't run rcup: it relinks $HOME and is the human's step.
5. Vim: in vimrc.local, add an `if has('mac') ... else ... endif` split. Restore the osascript light/dark detection (UpdateColorScheme, catppuccin-latte in light mode) on Mac only; everywhere else stays set background=dark + habamax. The removed function is in git history: `git log -p vimrc.local`, the commit before the 2026-09-30 "always dark" change. tmux: check tmux.conf.local for Mac-only bits (pbcopy/pbpaste, reattach-to-user-namespace, open). Guard any you find with if-shell on `uname`; if there are none, change nothing.
6. CLAUDE.md, "Layout": replace the zshrc.branch.local mention with zsh/os/ and the "guard on existence first, OS second" rule.

## Also
- Follow the repo's convention: a dated comment above each added or moved setting saying why (e.g. `# Moved 2026-09-30 from zshrc.branch.local: macOS only`).
- Check the syntax of every zsh file you touch with `zsh -n <file>`. You can't `exec zsh` in a worktree meaningfully, so say in your summary what the human should check after rcup.
- Old branches (plan section "Old branches", step 1 only, read-only): diff each of origin/dalek, origin/m1mbp, origin/lifeomic, origin/metacx, origin/ailin.local and origin/sunquan.local against main for zshrc.local, zshenv.local, zshrc.branch.local and aliases.local, using the existing remote-tracking refs (no fetch). List anything worth keeping in your summary; don't port it. Tagging and deleting the branches isn't part of this task.

## Out of scope
- rcup, verifying on macOS, archiving or deleting branches (the human and orchestrator do these after the merge).
- zfunc/_poetry: leave it alone. The human will decide separately.

## Done when
The branch has the changes above in small, focused commits; `zsh -n` passes on every touched zsh file; and the summary lists: the human's rcup and verification steps (remove any dangling ~/.zshrc.branch.local; `echo $PATH` shows no Mac paths on Linux; no thoughtbot zshenv PATH warning), plus the old-branch findings.
