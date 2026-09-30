# macOS-only config, sourced from zshrc.local via ~/.zsh/os/$(uname -s).zsh.
# Lives under zsh/os/, not zsh/configs/, because thoughtbot sources everything
# in ~/.zsh/configs/ on every OS.
# Added 2026-09-30 (dl-c5fc), moved from zshrc.branch.local: macOS-only paths.

# uv cache on the external data volume
# Moved 2026-09-30 from zshrc.branch.local: macOS only; guarded on the volume
# (turned off on the Linux NUC 2026-09-30 because /Volumes/Data doesn't exist)
[[ -d /Volumes/Data ]] && export UV_CACHE_DIR=/Volumes/Data/.cache/uv

# Java
# Moved 2026-09-30 from zshrc.branch.local: macOS only path
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home

# Android SDK
# Moved 2026-09-30 from zshrc.branch.local: macOS only (~/Library)
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# >>> conda initialize >>>
# Moved 2026-09-30 from zshrc.branch.local: macOS only (Homebrew Caskroom)
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
