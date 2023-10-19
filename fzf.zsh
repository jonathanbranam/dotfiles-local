# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/jbranam/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/jbranam/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/jbranam/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/Users/jbranam/.fzf/shell/key-bindings.zsh"
