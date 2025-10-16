#!/bin/bash

set -e

echo "=== Installing Dotfiles ==="
echo ""

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Dotfiles directory: $DOTFILES_DIR"
echo ""

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ]; then
        echo "  Removing existing symlink: $target"
        rm "$target"
    elif [ -f "$target" ]; then
        echo "  Backing up existing file: $target -> $target.backup"
        mv "$target" "$target.backup"
    fi

    echo "  Creating symlink: $target -> $source"
    ln -s "$source" "$target"
}

# Install dotfiles
echo "Installing configuration files..."

create_symlink "$DOTFILES_DIR/config/shell/bashrc" "$HOME/.bashrc"
create_symlink "$DOTFILES_DIR/config/shell/zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/config/editors/vimrc" "$HOME/.vimrc"
create_symlink "$DOTFILES_DIR/config/editors/tmux.conf" "$HOME/.tmux.conf"
create_symlink "$DOTFILES_DIR/config/git/gitconfig" "$HOME/.gitconfig"

echo ""
echo "=== Installation Complete ==="
echo ""
echo "To set up development tools, run:"
echo "  cd $DOTFILES_DIR"
echo "  ./scripts/generic_setup.sh"
echo ""
echo "To set up VS Code, run:"
echo "  cd $DOTFILES_DIR"
echo "  ./scripts/setup-vscode.sh"
echo ""
echo "Reload your shell configuration with:"
echo "  source ~/.bashrc    # for bash"
echo "  source ~/.zshrc     # for zsh"
