if command -v git >/dev/null; then
    # Git aliases
    alias g='git'
    alias gs='git status'
    alias ga='git add'
    alias gc='git commit'
    alias gp='git push'
    alias gl='git pull'
    alias gd='git diff'
    alias gco='git checkout'

    # FZF enhanced git commands
    if command -v fzf >/dev/null; then
        # Interactive branch checkout
        alias gb='git branch | fzf --height 40% --preview "git log --color=always {1}" | xargs git checkout'

        # Interactive git add
        alias gaa='git status -s | fzf -m --height 40% | awk "{print \$2}" | xargs git add'

        # Interactive git log
        alias glog='git log --oneline | fzf --preview "git show --color=always {1}"'
    fi

    # Git configuration for Linux
    git config --global core.editor "vim"
    git config --global core.fileMode true
    git config --global core.autocrlf input
fi
