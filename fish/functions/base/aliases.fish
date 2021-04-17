# Dont repeat attributes
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
