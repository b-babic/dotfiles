# System paths
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Local bin
export PATH="$HOME/.local/bin:$PATH"

# Cargo (Rust)
[[ -d "$HOME/.cargo/bin" ]] && export PATH="$HOME/.cargo/bin:$PATH"

# Go
[[ -d "/usr/local/go/bin" ]] && export PATH="/usr/local/go/bin:$PATH"
[[ -d "$HOME/go/bin" ]] && export PATH="$HOME/go/bin:$PATH"

# Node global packages
[[ -d "$HOME/.npm-global/bin" ]] && export PATH="$HOME/.npm-global/bin:$PATH"

# Ruby gems
if command -v ruby >/dev/null; then
    export PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
fi
