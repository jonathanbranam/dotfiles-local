# dotfiles-local

Personal dotfiles that overlay [thoughtbot/dotfiles](https://github.com/thoughtbot/dotfiles), installed with
[rcm](https://github.com/thoughtbot/rcm). See `CLAUDE.md` for the layout and conventions.

## Install

Each machine has a `host-<name>/` folder. Its `rcrc` becomes `~/.rcrc` (a symlink back into this repo), and its
other files (e.g. `vimrc.host`) are linked only on that machine.

Prerequisites: rcm installed, `~/dotfiles` (thoughtbot) cloned, and this repo cloned to the path named in
`DOTFILES_DIRS` of the machine's `rcrc`.

1. Fetch the submodule (tmux plugin manager):

   ```
   git submodule update --init
   ```

2. First run only — bootstrap, pointing rcup at the host's rcrc and naming the host:

   ```
   RCRC=<clone>/host-<name>/rcrc rcup -B <name>
   ```

   This links `host-<name>/rcrc` to `~/.rcrc`, so `HOSTNAME` is set from then on.
3. Afterwards, plain `rcup` re-syncs. Run it after adding or renaming a top-level file.

### Adding or renaming a machine

Create `host-<name>/` with an `rcrc` (copy another host's, change `HOSTNAME` and `DOTFILES_DIRS`) plus any
`*.host` files, commit, then run the bootstrap above on that machine. To rename, `git mv` the folder, edit
`HOSTNAME` in its `rcrc`, and re-run the bootstrap with the new name.

## Dalek

```
git clone <this-repo-url> ~/dotfiles-local
cd ~/dotfiles-local
git submodule update --init
RCRC=$HOME/dotfiles-local/host-dalek/rcrc rcup -B dalek
rcup
ls -l ~/.rcrc ~/.vimrc.local ~/.vimrc.host ~/.zshrc.local   # should point into ~/dotfiles-local
lsrc | grep dotfiles-local | head                             # optional: list what rcup manages
```

`~/.rcrc` should link to `~/dotfiles-local/host-dalek/rcrc`, and `~/.vimrc.host` to `host-dalek/vimrc.host`.
