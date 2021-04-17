# Check if required tools are available
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Basic system aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -h'

# Directory navigation
if command_exists fzf; then
    alias fd='cd $(find . -type d | fzf --height 40%)'
else
    alias fd='cd $(find . -type d | less)'
fi

# File operations
if command_exists fzf && command_exists bat; then
    alias vf='vim $(fzf --height 40% --preview "bat --style=numbers --color=always {}")'
else
    alias vf='vim $(find . -type f | less)'
fi

# Package management
if command_exists apt; then
    alias update='sudo apt update && sudo apt upgrade'
elif command_exists dnf; then
    alias update='sudo dnf update'
elif command_exists pacman; then
    alias update='sudo pacman -Syu'
fi

# Include our previously discussed FZF-enhanced aliases
# source_if_exists "$DOTFILES/modules/linux/fzf.zsh"
