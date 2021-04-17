#!/bin/sh

## Install fish from brew and set as default shell
brew install fish
echo "/opt/homebrew/bin/fish" | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish

# Install fisher plugin manager
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
# curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# Symlink the config file
ln -s ~/.dotfiles/fish/fish.conf ~/.config/fish/fish.conf

## Plugins
fisher add rstacruz/fish-asdf
fisher install jorgebucaran/hydro
