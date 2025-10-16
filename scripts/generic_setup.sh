#!/bin/bash

set -e

echo "=== Development Environment Setup ==="
echo ""

# Detect OS and package manager
if command -v apt-get &> /dev/null; then
    PKG_MANAGER="apt-get"
    UPDATE_CMD="apt-get update"
    INSTALL_CMD="apt-get install -y"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
    UPDATE_CMD="yum check-update || true"
    INSTALL_CMD="yum install -y"
elif command -v brew &> /dev/null; then
    PKG_MANAGER="brew"
    UPDATE_CMD="brew update"
    INSTALL_CMD="brew install"
else
    echo "Error: No supported package manager found (apt-get, yum, or brew)"
    exit 1
fi

echo "Detected package manager: $PKG_MANAGER"
echo ""

# Update package lists
echo "Updating package lists..."
$UPDATE_CMD
echo ""

# Install curl
if command -v curl &> /dev/null; then
    echo "✓ curl already installed"
else
    echo "Installing curl..."
    $INSTALL_CMD curl
    echo "✓ curl installed"
fi
echo ""

# Install uv
if command -v uv &> /dev/null; then
    echo "✓ uv already installed"
else
    echo "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    export PATH="$HOME/.cargo/bin:$PATH"
    echo "✓ uv installed"
fi
echo ""

# Install Rust/cargo
if command -v cargo &> /dev/null; then
    echo "✓ Rust/cargo already installed"
else
    echo "Installing Rust/cargo..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    echo "✓ Rust/cargo installed"
fi
echo ""

# Install ripgrep
if command -v rg &> /dev/null; then
    echo "✓ ripgrep already installed"
else
    echo "Installing ripgrep..."
    cargo install ripgrep
    echo "✓ ripgrep installed"
fi
echo ""

# Install Node.js and npm
if command -v node &> /dev/null && command -v npm &> /dev/null; then
    echo "✓ Node.js and npm already installed"
else
    echo "Installing Node.js and npm..."
    if [ "$PKG_MANAGER" = "apt-get" ]; then
        curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
        $INSTALL_CMD nodejs
    elif [ "$PKG_MANAGER" = "yum" ]; then
        curl -fsSL https://rpm.nodesource.com/setup_lts.x | bash -
        $INSTALL_CMD nodejs
    elif [ "$PKG_MANAGER" = "brew" ]; then
        $INSTALL_CMD node
    fi
    echo "✓ Node.js and npm installed"
fi
echo ""

# Install direnv
if command -v direnv &> /dev/null; then
    echo "✓ direnv already installed"
else
    echo "Installing direnv..."
    if [ "$PKG_MANAGER" = "apt-get" ]; then
        $INSTALL_CMD direnv
    elif [ "$PKG_MANAGER" = "yum" ]; then
        $INSTALL_CMD direnv
    elif [ "$PKG_MANAGER" = "brew" ]; then
        $INSTALL_CMD direnv
    fi
    echo "✓ direnv installed"
fi
echo ""

# Install Claude Code CLI
if command -v claude &> /dev/null; then
    echo "✓ Claude Code already installed"
else
    echo "Installing Claude Code CLI..."
    npm install -g @anthropic-ai/claude-code
    echo "✓ Claude Code installed"
fi
echo ""

echo "=== Setup Complete ==="
echo ""
echo "You may need to reload your shell or run:"
echo "  source \$HOME/.cargo/env"
echo ""
echo "Installed tools:"
echo "  - curl: $(curl --version | head -n1)"
echo "  - uv: $(uv --version 2>/dev/null || echo 'restart shell to use')"
echo "  - cargo: $(cargo --version)"
echo "  - ripgrep: $(rg --version | head -n1)"
echo "  - node: $(node --version 2>/dev/null || echo 'restart shell to use')"
echo "  - npm: $(npm --version 2>/dev/null || echo 'restart shell to use')"
echo "  - direnv: $(direnv --version 2>/dev/null || echo 'restart shell to use')"
echo "  - claude: $(claude --version 2>/dev/null || echo 'restart shell to use')"