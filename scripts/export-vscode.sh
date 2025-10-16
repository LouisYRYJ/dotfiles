#!/bin/bash

set -e

echo "=== Exporting VS Code Configuration ==="
echo ""

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VSCODE_CONFIG_DIR="$DOTFILES_DIR/config/vscode"

# Check if VS Code is installed
if ! command -v code &> /dev/null; then
    echo "Error: VS Code not found"
    exit 1
fi

mkdir -p "$VSCODE_CONFIG_DIR"

# Export extensions
echo "Exporting extensions..."
code --list-extensions | grep -v "^Extensions installed on SSH:" > "$VSCODE_CONFIG_DIR/extensions.txt"
echo "✓ Exported $(wc -l < "$VSCODE_CONFIG_DIR/extensions.txt") extensions"
echo ""

# Export settings
case "$OSTYPE" in
    linux*) VSCODE_USER_DIR="$HOME/.config/Code/User" ;;
    darwin*) VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User" ;;
    msys*|cygwin*) VSCODE_USER_DIR="$APPDATA/Code/User" ;;
    *) echo "Error: Unsupported OS"; exit 1 ;;
esac

if [ -f "$VSCODE_USER_DIR/settings.json" ]; then
    cp "$VSCODE_USER_DIR/settings.json" "$VSCODE_CONFIG_DIR/settings.json"
    echo "✓ Exported settings.json"
else
    echo "⚠ No settings.json found"
fi

echo ""
echo "=== Export Complete ==="
echo "Files saved to: $VSCODE_CONFIG_DIR"
