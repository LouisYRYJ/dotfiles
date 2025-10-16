#!/bin/bash

set -e

echo "=== VS Code Setup ==="
echo ""

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VSCODE_CONFIG_DIR="$DOTFILES_DIR/config/vscode"

# Check if VS Code is installed
if ! command -v code &> /dev/null; then
    echo "Error: VS Code not found. Install it first."
    exit 1
fi

# Install extensions
if [ -f "$VSCODE_CONFIG_DIR/extensions.txt" ]; then
    echo "Installing extensions..."
    while IFS= read -r extension || [ -n "$extension" ]; do
        [[ -z "$extension" || "$extension" =~ ^#.*$ || "$extension" =~ ^Extensions\ installed ]] && continue
        echo "  - $extension"
        code --install-extension "$extension" --force
    done < "$VSCODE_CONFIG_DIR/extensions.txt"
    echo "✓ Extensions installed"
else
    echo "⚠ No extensions.txt found"
fi
echo ""

# Copy settings
case "$OSTYPE" in
    linux*) VSCODE_USER_DIR="$HOME/.config/Code/User" ;;
    darwin*) VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User" ;;
    msys*|cygwin*) VSCODE_USER_DIR="$APPDATA/Code/User" ;;
    *) echo "Error: Unsupported OS"; exit 1 ;;
esac

mkdir -p "$VSCODE_USER_DIR"

if [ -f "$VSCODE_CONFIG_DIR/settings.json" ]; then
    cp "$VSCODE_CONFIG_DIR/settings.json" "$VSCODE_USER_DIR/settings.json"
    echo "✓ Settings applied"
else
    echo "⚠ No settings.json found"
fi

echo ""
echo "=== Setup Complete ==="