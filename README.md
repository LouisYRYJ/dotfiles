# Dotfiles

Personal development environment configuration files.

## Quick Setup

Run the setup script to install essential development tools:

```bash
./generic_setup.sh
```

This will install:
- curl
- uv (Python package manager)
- Rust/cargo
- ripgrep
- Node.js and npm
- Claude Code CLI

## Manual Installation

To use these dotfiles, clone the repository and create symlinks:

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
./install.sh
```

## What's Included

- **generic_setup.sh** - Automated setup script for development tools
- **.bashrc** - Bash shell configuration
- **.zshrc** - Zsh shell configuration with Powerlevel10k
- **.vimrc** - Vim editor configuration
- **.tmux.conf** - Tmux terminal multiplexer configuration
- **.gitconfig** - Git configuration

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