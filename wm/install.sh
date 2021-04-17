#!/bin/bash

# install.sh
DOTFILES="$HOME/.dotfiles/wm"
CONFIG_DIR="$HOME/.config"

# Error handling
set -e

print_message() {
    echo -e "\e[1;34m[*] $1\e[0m"
}

check_status() {
    if [ $? -eq 0 ]; then
        echo -e "\e[1;32m[✓] $1 completed successfully\e[0m"
    else
        echo -e "\e[1;31m[×] $1 failed\e[0m"
        exit 1
    fi
}

create_symlinks() {
    print_message "Creating symlinks..."

    # Create config directory if it doesn't exist
    mkdir -p "$CONFIG_DIR"

    # Array of configs to symlink
    configs=(
        "i3"
        "polybar"
        "rofi"
        "ghostty"
        "dunst"
    )

    for config in "${configs[@]}"; do
        if [ -d "$CONFIG_DIR/$config" ]; then
            mv "$CONFIG_DIR/$config" "$CONFIG_DIR/$config.backup"
        fi
        ln -sf "$DOTFILES/config/$config" "$CONFIG_DIR/$config"
    done

    # Sublime Text config
    mkdir -p "$HOME/.config/sublime-text/Packages/User"
    ln -sf "$DOTFILES/config/sublime-text/"* "$HOME/.config/sublime-text/Packages/User/"

    # Scripts
    mkdir -p "$HOME/.local/bin"
    ln -sf "$DOTFILES/bin/"* "$HOME/.local/bin/"

    check_status "Symlink creation"
}

install_packages() {
    print_message "Installing required packages..."

    # Add repositories
    sudo add-apt-repository ppa:regolith-linux/release -y

    # Update system
    sudo apt update && sudo apt upgrade -y

    # Install packages
    sudo apt install -y \
        zsh \
        curl \
        wget \
        git \
        vim \
        htop \
        tlp \
        powertop \
        preload \
        i3-gaps \
        polybar \
        rofi \
        feh \
        picom \
        i3lock-fancy \
        dunst \
        arandr \
        lxappearance \
        network-manager \
        blueman \
        pavucontrol

    check_status "Package installation"
}

install_ghostty() {
    print_message "Installing Ghostty..."

    # Download Ghostty
    wget -P /tmp https://github.com/mkasberg/ghostty-ubuntu/releases/download/1.1.0-0-ppa1/ghostty_1.1.0-0.ppa1_amd64_24.04.deb

    # Install Ghostty
    sudo apt install -y /tmp/ghostty_*.deb

    check_status "Ghostty installation"
}

install_sublime() {
    print_message "Installing Sublime Text..."

    # Install GPG key
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

    # Add repository
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

    # Install Sublime Text
    sudo apt update
    sudo apt install -y sublime-text

    check_status "Sublime Text installation"
}

setup_zsh() {
    print_message "Setting up ZSH..."

    # Install zsh if not already installed
    sudo apt install -y zsh

    # Create symlink for zsh config
    mkdir -p "$HOME/.config/zsh"
    ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

    # Set zsh as default shell if it isn't already
    if [[ $SHELL != "/usr/bin/zsh" ]]; then
        chsh -s $(which zsh)
    fi

    check_status "ZSH setup"
}

install_mise() {
    print_message "Installing mise..."

    curl https://mise.run | sh
    echo 'eval "$(~/.local/bin/mise activate zsh)"' >> ~/.zshrc

    # Install runtimes
    mise use -g node@lts
    mise use -g go@latest

    check_status "mise installation"
}

install_fonts() {
    print_message "Installing JetBrains Mono font..."

    mkdir -p ~/.local/share/fonts
    curl -fLo "/tmp/JetBrainsMono.zip" https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
    unzip -o "/tmp/JetBrainsMono.zip" -d "/tmp/JetBrainsMono"
    cp /tmp/JetBrainsMono/fonts/ttf/* ~/.local/share/fonts/
    fc-cache -f -v

    check_status "Font installation"
}

main() {
    print_message "Starting system configuration..."

    install_packages
    install_ghostty
    install_sublime
    install_fonts
    setup_zsh
    install_mise
    create_symlinks

    print_message "Installation complete! Please log out and log back in to activate zsh"
    print_message "Then, reboot your system to ensure all changes take effect."
}
