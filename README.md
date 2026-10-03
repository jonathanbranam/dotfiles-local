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

### Switching an existing machine to a different clone

Plain `rcup` leaves existing links into the old clone unchanged. Repoint them (verified on the NUC 2026-10-03):

```
rcup -K -f -B <name> vimrc.local tmux.conf.local zshrc.local
```

Then check that no links into the old clone remain, e.g. `lsrc | grep <old-clone-path>` prints nothing.

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

## Auto-update

The NUC needs no job: its `$HOME` links into the bridle clone, which bridle keeps current. Other machines (Dalek
and any other) run `local/bin/dotfiles-update` on a timer. It cds to the clone (argument, default
`~/dotfiles-local`), skips if the worktree is dirty or not on `main`, runs `git pull --ff-only` then `rcup -K`
(links only, skipping thoughtbot hooks). Plugin updates stay manual via `rcup` or `:PlugUpdate`. Never forces.
Skips and failures are logged with timestamps to `~/.local/state/dotfiles-update.log`; that log is how you
notice a problem.

### macOS (launchd), every 15 minutes

Save as `~/Library/LaunchAgents/us.branam.dotfiles-update.plist` (not kept in this repo):

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>us.branam.dotfiles-update</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/sh</string>
    <string>-c</string>
    <string>PATH=/opt/homebrew/bin:/usr/local/bin:$PATH; exec "$HOME/dotfiles-local/local/bin/dotfiles-update"</string>
  </array>
  <key>StartInterval</key><integer>900</integer>
  <key>RunAtLoad</key><true/>
</dict>
</plist>
```

Install on Dalek (the `PATH` line lets launchd find Homebrew's `rcup`):

```
mkdir -p ~/.local/state ~/Library/LaunchAgents
$EDITOR ~/Library/LaunchAgents/us.branam.dotfiles-update.plist   # paste the plist above
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/us.branam.dotfiles-update.plist
launchctl kickstart gui/$(id -u)/us.branam.dotfiles-update
tail ~/.local/state/dotfiles-update.log
```

Remove with `launchctl bootout gui/$(id -u)/us.branam.dotfiles-update`.

### Linux alternatives

cron (`crontab -e`):

```
*/15 * * * * $HOME/dotfiles-local/local/bin/dotfiles-update
```

systemd user timer: `~/.config/systemd/user/dotfiles-update.service`

```
[Service]
Type=oneshot
ExecStart=%h/dotfiles-local/local/bin/dotfiles-update
```

and `dotfiles-update.timer`, enabled with `systemctl --user enable --now dotfiles-update.timer`:

```
[Timer]
OnBootSec=1min
OnUnitActiveSec=15min

[Install]
WantedBy=timers.target
```
