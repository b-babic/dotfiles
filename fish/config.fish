set -x LANG en_US.UTF-8

# Base imports
source ~/.dotfiles/fish/functions/base/path.fish
source ~/.dotfiles/fish/functions/base/aliases.fish
source ~/.dotfiles/fish/functions/base/executables.fish

# Other
source (brew --prefix asdf)/libexec/asdf.fish

# Overrides
source ~/.dotfiles/fish/functions/overrides/prompt.fish
source ~/.dotfiles/fish/functions/overrides/bat.fish
source ~/.dotfiles/fish/functions/overrides/fuzzy.fish

# Defaults
# Remove fish default greeting
set --global fish_greeting

# source /Users/ben/.docker/init-fish.sh || true # Added by Docker Desktop
