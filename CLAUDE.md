# dotfiles-local

Personal dotfiles that overlay [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles), which lives
separately at `~/dotfiles`. This repo only holds the personal layer — don't assume it's self-contained;
many files here are `*.local` companions to files that actually live in `~/dotfiles`.

A similar setup (different repo) is used for a work laptop, so changes here should stay personal-machine
specific unless noted otherwise.

## How the overlay works (rcm / rcup)

Both repos are installed into `$HOME` using [rcm](https://github.com/thoughtbot/rcm)'s `rcup` command, which
symlinks each file into place (e.g. `vimrc.local` -> `~/.vimrc.local`, `zshrc.local` -> `~/.zshrc.local`).

`~/.rcrc` controls the merge. It is a symlink to the machine's tracked `host-<name>/rcrc` (bootstrap and
install steps: `README.md`). Shape, from `host-dalek/rcrc`:

```
DOTFILES_DIRS="$HOME/dotfiles-local $HOME/dotfiles"
HOSTNAME="dalek"
EXCLUDES="*.md LICENSE CODEOWNERS"
COPY_ALWAYS="git_template/HEAD"
```

`host-nuc/rcrc` differs only in `HOSTNAME="nuc"` and a first `DOTFILES_DIRS` entry of
`/srv/shared/work/dotfiles-work/dotfiles-local`.

- `DOTFILES_DIRS` lists both source directories, this repo first. When rcup walks the combined tree, a file
  present in `dotfiles-local` wins over the same-named file in `dotfiles`.
- thoughtbot's dotfiles source their `*.local` counterparts by convention (e.g. `~/.zshrc` sources
  `~/.zshrc.local`, `~/.vimrc` sources `~/.vimrc.local`), so most files in this repo are named `<name>.local`
  and are meant to be *appended* behavior, not full replacements.
- Some files here (`gitignore`, `tmux.conf.local`, etc.) replace or extend the base config directly rather than
  going through the `.local` sourcing convention — check the base repo (`~/dotfiles`) if it's unclear whether a
  given name is additive or standalone.
- Running `rcup` again re-syncs symlinks after adding/removing files here — do that after structural changes
  (new top-level file, renamed file), not after editing an existing symlinked file's contents.

## Layout

- `zshrc.local`, `zshenv.local`, `aliases.local` — shell config appended to thoughtbot's zsh setup.
- `zsh/os/Darwin.zsh`, `zsh/os/Linux.zsh` — per-OS zsh config, sourced at the end of `zshrc.local` by `uname -s`.
  They live under `zsh/os/`, never `zsh/configs/` (thoughtbot sources everything there on every OS). Rule:
  guard on existence first, OS second — put a setting in `zshrc.local` behind a `[[ -d/-f ... ]]` check when
  that works anywhere; only genuinely OS-divergent things go in an OS file. Existence guards are for "use it if installed", never for
  choosing between machines — that is what `host-<name>/` is for.
- `host-<name>/` (`host-nuc/`, `host-dalek/`) — per-machine config via rcm host folders: rcup links the files
  only on the machine with that name (`host-nuc/vimrc.host` -> `~/.vimrc.host`). `vimrc.local`, `zshrc.local` and
  `tmux.conf.local` each load their `*.host` file if present. Per-machine differences go here; OS differences stay
  in `zsh/os/`. The name comes from `HOSTNAME=` in `~/.rcrc` (or `rcup -B <name>`). Each folder's `rcrc` is `~/.rcrc`.
- `vimrc.local`, `vimrc.bundles.local`, `vim/` — vim config and plugin bundles; `vim/after/` holds
  ftplugin/plugin overrides loaded after the base vim setup.
- `tmux.conf.local`, `tmux/plugins/tpm` (git submodule) — tmux config and the Tmux Plugin Manager.
- `gitconfig.local`, `gitignore`, `git_template.local/` — git config, global ignore, and template hooks
  (e.g. NOCOMMIT pre-commit hook).
- `config/` — XDG-style app configs (karabiner, flake8) symlinked under `~/.config/`.
- `local/bin/` — personal scripts intended to land on `$PATH`.
- `psqlrc.local`, `ripgreprc`, `fzf.zsh`, `asdf/`, `emacs.d/` — misc tool configs.

## Working in this repo

- When adding or changing a config setting, leave a comment above it noting *why* it was added and the date
  (e.g. `# Added 2026-08-15 for Claude and Pi` — see existing examples in `vimrc.local` and `tmux.conf.local`).
  This is how changes get traced back to their reason later, since git blame alone doesn't capture intent well
  enough across a dotfiles repo that's edited in small, scattered increments.
- Treat every `*.local` file as a supplement to a same-stem file in `~/dotfiles`; when debugging behavior, check
  both repos, not just this one.
- New top-level files need to actually get symlinked — run `rcup` (or ask the user to) after adding one.
- The `tmux/plugins/tpm` submodule is managed by tmux's plugin manager itself (`prefix + I` to install), not
  manually edited.
- No build/test tooling — changes are config files, verified by sourcing/reloading the relevant tool
  (`tmux source-file`, `:source $MYVIMRC`, `exec zsh`, etc.).

<!-- bridle:managed:start -->
This project's workflow rules, current task and role priming are rendered by
bridle, not written here. Read the rule files (markdown, one per rule id)
in `.bridle/rules/` and in the workflow checkout's `base/rules/` (`workflow`
in `.bridle/config.toml`) at the start of a session — don't rely on this
file for rule content. The orchestrator also runs `bridle prime orchestrator`.
<!-- bridle:managed:end -->
