+++
id = "dl-c5fc"
title = "Replace zshrc.branch.local with per-OS zsh config (zsh/os/), vim/tmux OS split"
kind = "feature"
state = "planned"
created_at = "2026-09-30T22:23:14.121Z"
updated_at = "2026-09-30T22:33:54.155901037Z"
size = "M"
summary = """
Replaced zshrc.branch.local with existence-guarded common config in zshrc.local (~/.local/bin, pyenv, poetry fpath/compinit only if ~/.zfunc exists, RIPGREP_CONFIG_PATH, one cargo env load, GPG_TTY) plus zsh/os/Darwin.zsh (UV_CACHE_DIR guarded on /Volumes/Data, JAVA_HOME, Android SDK, conda Caskroom) and a near-empty zsh/os/Linux.zsh; zshrc.local ends with the `uname -s` source line. Dead commented blocks dropped. fzf.zsh: ~/.fzf/bin guarded on -d (works on both OSes, so kept common rather than Linux.zsh). vimrc.local: has('mac') restores osascript light/dark (catppuccin-latte); else dark+habamax. tmux.conf.local has no Mac-only bits: unchanged. CLAUDE.md Layout updated. No CHANGELOG in repo. `zsh -n` passes on zshrc.local, fzf.zsh, both OS files. Not done: rcup, zfunc/_poetry (untouched).

Human steps after merge: run rcup; `rm ~/.zshrc.branch.local` if a dangling symlink remains; open a new shell (exec zsh): on Linux `echo $PATH` has no /Library, /usr/local/Caskroom or ~/Library/Android entries; no thoughtbot zshenv PATH warning; on macOS check `echo $JAVA_HOME $UV_CACHE_DIR`, `conda --version`, and that vim picks light/dark. Note: poetry compinit now only runs if ~/.zfunc exists; zfunc/_poetry still hardcodes /Users/jbranam paths.

Old branches (diff of branch vs merge-base with main, zshrc.local/zshenv.local/zshrc.branch.local/aliases.local): dalek, m1mbp, lifeomic: nothing unique. metacx: old rbenv init, pyenv init (eval "$(pyenv init -)"), anaconda at /Users/jbranam/anaconda3, n-install N_PREFIX=$HOME/n, Google Cloud SDK path/completion includes (~/installs/google-cloud-sdk), lerna/yarn npx aliases; asdf disabled. ailin.local: asdf miniconda on /Volumes/user, asdf.sh (stale). sunquan.local: SPARK_HOME=/opt/spark, asdf miniconda conda init (/Users/jonathan). Only maybe-worth-keeping: gcloud includes and N_PREFIX if still used; rest is stale. Nothing ported."""
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
- Commit 7cdc8e3 holds the NUC (Linux) fixes: fzf.zsh (~/.fzf), the cargo env line in zshrc.local, UV_CACHE_DIR turned off, vim always dark. Each has a comment starting `NUC (Linux)` / `OS split (dl-c5fc)` that says where it goes. Put each in the right OS place, then remove the markers.
- Follow the repo's convention: a dated comment above each added or moved setting saying why (e.g. `# Moved 2026-09-30 from zshrc.branch.local: macOS only`).
- Check the syntax of every zsh file you touch with `zsh -n <file>`. You can't `exec zsh` in a worktree meaningfully, so say in your summary what the human should check after rcup.
- Old branches (plan section "Old branches", step 1 only, read-only): diff each of origin/dalek, origin/m1mbp, origin/lifeomic, origin/metacx, origin/ailin.local and origin/sunquan.local against main for zshrc.local, zshenv.local, zshrc.branch.local and aliases.local, using the existing remote-tracking refs (no fetch). List anything worth keeping in your summary; don't port it. Tagging and deleting the branches isn't part of this task.

## Out of scope
- rcup, verifying on macOS, archiving or deleting branches (the human and orchestrator do these after the merge).
- zfunc/_poetry: leave it alone. The human will decide separately.

## Done when
The branch has the changes above in small, focused commits; `zsh -n` passes on every touched zsh file; and the summary lists: the human's rcup and verification steps (remove any dangling ~/.zshrc.branch.local; `echo $PATH` shows no Mac paths on Linux; no thoughtbot zshenv PATH warning), plus the old-branch findings.

## Thread

### note · agent:ossplit · 2026-09-30T22:33:54.155Z
done: zsh/os split, guarded common config, vim has('mac'), CLAUDE.md; zsh -n ok, main merged (already up to date); 7396cd8
