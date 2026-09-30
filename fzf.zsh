# Setup fzf
# ---------
# Changed 2026-09-30: fzf lives in ~/.fzf (was hardcoded /Users/jbranam/.fzf);
# guarded on existence so it works on any OS
if [[ -d "$HOME/.fzf/bin" && ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

source <(fzf --zsh)
