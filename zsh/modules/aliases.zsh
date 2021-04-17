# Movement
alias cls='clear'
alias cat='bat --theme GitHub'
alias ll='ls -alGh'
alias ls='ls -Gh'
alias ..='cd ..'
alias .='cd ~'

# package publishing
alias npmpublish='npm publish --access public'

# Apps
alias subl="open -a /Applications/Sublime\ Text.app"
alias vi='nvim'
alias cligit='gitui'
alias clidocker='lazydocker'

# Misc
alias brewup="brew update; brew upgrade; brew cleanup; brew doctor"

# Working directories
alias .projects='cd ~/Projects'
alias .work='cd ~/Work'
alias .dev='cd ~/Dev'
alias .dotfiles='cd ~/.dotfiles'

alias aliases='cat ~/.dotfiles/zsh/aliases.zsh'

# Source
alias rr='source ~/.dotfiles/zsh/.zshrc'

# Tmux
alias ts='tmux new-session -d -s'
alias ta='tmux attach-session -d -t'
alias tk='tmux kill-session -t'
alias tl='tmux ls'

# Spotlight fix
alias fixspot="find . -type d -path './.*' -prune -o -path './Pictures*' -prune -o -path './Library*' -prune -o -path '*node_modules/*' -prune -o -type d -name 'node_modules' -exec touch '{}/.metadata_never_index' \; -print"

# Ports
# Print the process name and PID listening on a given port
function port() {
  # Show message if no port is given
    if [ -z "$1" ]; then
        echo "Usage: port <port>"
        return 1
    fi

    # Print default message if no process is found
    lsof -i :$1 | awk 'NR==2 {print $1, $2}' || echo "No process found listening on port $1"
}

# Kill a process by PID
function kill() {
    # Show message if no PID is given
    if [ -z "$1" ]; then
        echo "Usage: kill <pid>"
        return 1
    fi

  kill -9 $1 | awk 'NR==2 {print $1, $2}'
}
