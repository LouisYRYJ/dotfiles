# Dotfiles

Personal development environment configuration files.

## Structure

```
dotfiles/
├── config/
│   ├── shell/           # Shell configurations
│   │   ├── bashrc
│   │   └── zshrc
│   ├── editors/         # Editor configurations
│   │   ├── vimrc
│   │   └── tmux.conf
│   ├── git/             # Git configuration
│   │   └── gitconfig
│   └── vscode/          # VS Code configuration
│       ├── extensions.txt
│       └── settings.json
├── scripts/
│   ├── generic_setup.sh  # Install dev tools
│   ├── setup-vscode.sh   # Install VS Code config
│   └── export-vscode.sh  # Export current VS Code config
└── install.sh            # Symlink all dotfiles
```

## Quick Setup

1. Clone the repository:
```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
```

2. Install dotfiles (creates symlinks):
```bash
./install.sh
```

3. Install development tools:
```bash
./scripts/generic_setup.sh
```

4. Set up VS Code (optional):
```bash
./scripts/setup-vscode.sh
```

## Development Tools

The `generic_setup.sh` script installs:
- curl
- uv (Python package manager)
- Rust/cargo
- ripgrep
- Node.js and npm
- Claude Code CLI

## VS Code Setup

**Export your current VS Code config:**
```bash
./scripts/export-vscode.sh
```

**Install VS Code config on a new machine:**
```bash
./scripts/setup-vscode.sh
```

## Configurations

### Bash/Zsh
- History control and size settings
- Color support for ls and grep
- UTF-8 locale settings
- Cargo environment integration

### Vim
- 4-space indentation with spaces
- Relative and absolute line numbers
- Custom page navigation (Ctrl+F/Ctrl+G)

### Tmux
- Zsh as default shell
- Mouse support enabled
- 256 color support

### Git
- User name: LouisYRYJ
- Email: louis.yousif@yahoo.de

## Requirements

- Linux, macOS, or WSL
- Package manager: apt-get, yum, or brew
- Internet connection for installation

## License

Personal use