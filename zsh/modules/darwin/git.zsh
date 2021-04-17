# First check if fzf is available
if command -v fzf >/dev/null 2>&1; then
    __FZF_AVAILABLE=1
else
    __FZF_AVAILABLE=0
fi

# Core git helpers
function current_branch() {
    git branch --show-current 2>/dev/null
}

# Basic aliases - these work without fzf
alias g='git'
alias gs='git status'
alias gaa='git add --all'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gl='git log --graph --oneline --decorate'
alias gb='git branch --sort=committerdate'
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'
alias grh='git reset --hard'
alias grs='git reset --soft HEAD~1'

# Interactive functions with fzf fallbacks
if [[ $__FZF_AVAILABLE -eq 1 ]]; then
    # git add with fzf
    function ga() {
        local files
        files=$(git status -s | fzf -m --preview '
            file=$(echo {} | awk "{print \$2}")
            if [[ $(git diff --cached --name-only | grep -F "$file") ]]; then
                git diff --cached --color=always -- "$file"
            else
                git diff --color=always -- "$file"
            fi
        ' | awk '{print $2}')
        if [[ -n "$files" ]]; then
            git add ${files}
            git status -s
        fi
    }

    # git checkout/switch with fzf
    function gco() {
        local branches branch
        branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "$branches" | fzf --preview 'git log --oneline --graph --date=short --color --pretty="format:%C(auto)%cd %h%d %s" {}') &&
        git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    }

    # git diff with fzf
    function gd() {
        local files
        files=$(git status -s | fzf --preview 'git diff --color=always {}' | awk '{print $2}')
        if [[ -n "$files" ]]; then
            git diff ${files}
        fi
    }

    # git restore staged with fzf
    function grst() {
        local files
        files=$(git diff --cached --name-only | fzf -m --preview 'git diff --cached --color=always {}')
        if [[ -n "$files" ]]; then
            git restore --staged ${files}
            git status -s
        fi
    }

    # git show with fzf
    function gsh() {
        local commits commit
        commits=$(git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" --all) &&
        commit=$(echo "$commits" | fzf --ansi --no-sort --reverse --preview 'git show --color=always {2}') &&
        git show $(echo "$commit" | grep -o '[a-f0-9]\{7\}' | head -1)
    }

    # git switch branch with fzf
    function gsw() {
        local branches branch
        branches=$(git branch --all | grep -v HEAD) &&
        branch=$(echo "$branches" | fzf --preview 'git log --oneline --graph --date=short --color --pretty="format:%C(auto)%cd %h%d %s" {}') &&
        git switch $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
    }

    # git switch create with confirmation
    function gswc() {
        local branch_name
        echo -n "Enter new branch name: "
        read branch_name
        if [[ -n "$branch_name" ]]; then
            git switch -c "$branch_name"
        fi
    }

else
    # Non-interactive fallbacks
    alias ga='git add'
    alias gco='git checkout'
    alias gd='git diff'
    alias grst='git restore --staged'
    alias gsh='git show'
    alias gsw='git switch'
    alias gswc='git switch -c'
fi

# Git branch creation helper
function git_branch_exists() {
    git show-ref --verify --quiet "refs/heads/$1"
}

# Additional helpful git aliases that don't need fzf
alias gdh='git diff HEAD'
alias gdca='git diff --cached'
alias gds='git diff --staged'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
