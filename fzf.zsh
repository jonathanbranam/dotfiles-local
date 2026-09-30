# Setup fzf
# ---------
# NUC (Linux), 2026-09-30: fzf lives in ~/.fzf, not /Users/jbranam/.fzf.
# OS split (dl-c5fc): move to the Linux config (zsh/os/Linux.zsh).
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

source <(fzf --zsh)
