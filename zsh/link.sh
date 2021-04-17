DOTFILES_DIR="$HOME/.dotfiles"
ZSHRC_SOURCE="$DOTFILES_DIR/zsh/.zshrc"
ZSHRC_TARGET="$HOME/.zshrc"

# Create backup of existing .zshrc if it exists and is not a symlink
if [ -f "$ZSHRC_TARGET" ] && [ ! -L "$ZSHRC_TARGET" ]; then
    echo "Backing up existing .zshrc"
    mv "$ZSHRC_TARGET" "$ZSHRC_TARGET.backup"
fi

# Create symbolic link
echo "Creating symbolic link for .zshrc"
ln -sf "$ZSHRC_SOURCE" "$ZSHRC_TARGET"

echo "Done! .zshrc has been linked to $ZSHRC_SOURCE"
