# Defaults
set -gx PATH /usr/local/sbin $PATH
set -gx PATH /.local/share $PATH
# Homebrew
set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/sbin $PATH
# PNPM
set -gx PNPM_HOME "/Users/ben/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# Rust
set -gx PATH $HOME/.cargo/bin $PATH
# Composer
set -gx PATH $HOME/.composer/vendor/bin $PATH
