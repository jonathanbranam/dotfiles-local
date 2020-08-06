# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/jbranam/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/jbranam/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/jbranam/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/jbranam/.fzf/shell/key-bindings.zsh"
