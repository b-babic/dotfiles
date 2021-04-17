set -x LC_ALL en_US.UTF-8
set -x LC_CTYPE en_US.UTF-8

# Homebrew improve security
set -gx HOMEBREW_NO_INSECURE_REDIRECT 1
set -gx HOMEBREW_CASK_OPTS --require-sha
set -gx HOMEBREW_NO_ANALYTICS 1

set -l paths $HOME/go/bin \
    /usr/local/sbin \
    $HOME/.config/herd-lite/bin \
    /opt/homebrew/bin \
    $HOME/.composer/vendor/bin \
    $HOME/.local/bin

for path in $paths
    set -gxp PATH $path
end

set -gx GOBIN $HOME/go/bin
set -gx EDITOR nvim
set -gx FZF_CTRL_T_COMMAND nvim

# shell integration, if we don't set it, working directory features won't work
set -gx GHOSTTY_SHELL_INTEGRATION_XDG_DIR /Applications/Ghostty.app/Contents/Resources/ghostty/shell-integration

# git prompt settings
set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_showdirtystate yes
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_dirtystate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_conflictedstate "+"
set -g __fish_git_prompt_color_dirtystate yellow
set -g __fish_git_prompt_color_cleanstate green --bold
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_branch cyan --dim

# don't show any greetings
set fish_greeting ""

# Make sure to create virtual padding before and after commands in terminal.
function preexec --on-event fish_preexec
    echo
end

function postexec_test --on-event fish_postexec
    echo
end

# don't describe the command for darwin
# https://github.com/fish-shell/fish-shell/issues/6270
function __fish_describe_command
end

# Senstive functions which are not pushed to Github
# It contains work related stuff, some functions, aliases etc...
# source ~/.private.fish

set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths
set -g fish_user_paths /usr/local/opt/mysql-client/bin $fish_user_paths

set -gx ATUIN_NOBIND true
status --is-interactive
atuin init fish | source

mise activate fish | source

bind --erase \cr
bind --erase -M insert \cr

bind \cr _atuin_search
bind -M insert \cr _atuin_search

# KEYBINDINGS
# ==============================

function a
    abbr --add $argv
end

# Movement
a cls clear
a cat bat
a ll ls -alGh
a ls ls -Gh

# Git
a gp git pull origin
a gs git status
a gc git commit -m
a gl git log --graph --decorate --pretty=oneline --abbrev-commit
a gr git rebase --interactive --autosquash origin
a grn git rebase --interactive --autosquash HEAD~
a gu git reset --soft HEAD~1
a pullmaster git pull origin master --rebase
a pullmain git pull origin main --rebase

# SSH
a lk ssh-add --apple-load-keychain

# package publishing
a npmpublish npm publish --access public

# Apps
a vi nvim
a vim nvim
a cligit gitui
a clidocker lazydocker

# Working directories
a . cd ~
a .projects cd ~/Projects
a .work cd ~/Work
a .dev cd ~/Dev

a .dotfiles cd ~/.dotfiles
a edot nvim ~/.dotfiles

a .aliases bat ~/.dotfiles/fish/functions/base/aliases.fish

# Source
a reload exec fish

# Ports
a port lsof -i :
a kill kill -9

# Unset helper functions
functions -e a

# bun
# set --export BUN_INSTALL "$HOME/.bun"
# set --export PATH $BUN_INSTALL/bin $PATH
