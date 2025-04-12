# MacDotfile

[![macOS](https://img.shields.io/badge/macOS-13.0+-blue.svg)](https://www.apple.com/macos)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Homebrew](https://img.shields.io/badge/Homebrew-4.0+-orange.svg)](https://brew.sh)
[![GNU Stow](https://img.shields.io/badge/GNU%20Stow-2.3+-purple.svg)](https://www.gnu.org/software/stow/)
[![ZSH](https://img.shields.io/badge/ZSH-5.8+-red.svg)](https://www.zsh.org)
[![Neovim](https://img.shields.io/badge/Neovim-0.9+-green.svg)](https://neovim.io)
[![Tmux](https://img.shields.io/badge/Tmux-3.3+-blue.svg)](https://github.com/tmux/tmux)

This repository contains scripts and configurations to set up a development environment on macOS.

## Features

- 📦 Automated package installation via [Homebrew](https://brew.sh)
- 🔧 Dotfiles management using [GNU Stow](https://www.gnu.org/software/stow/)
- 🔄 Automatic backup of existing configurations
- ✨ Modern command-line tools and utilities

## Prerequisites

- macOS
- [Homebrew](https://brew.sh)
- [Git](https://git-scm.com)

## Quick Start

```bash
# Clone the repository
git clone https://github.com/achrafAa/macdotfile.git
cd macdotfile

# Install everything (packages and dotfiles)
make
```

### Installation Preview

![Installation Preview](https://raw.githubusercontent.com/achrafAa/macdotfile/main/assets/install-preview.png)

This preview shows:
- 📦 Package installation with version tracking
- 🔧 Dotfiles installation with backup creation
- ✨ Clean and informative output formatting

## Available Commands

| Command    | Description                           |
|------------|---------------------------------------|
| `make`     | Run the default installation (magic)  |
| `make magic`| Install everything                    |
| `make install` | Install packages using Homebrew   |
| `make dotfiles`| Install dotfiles using GNU Stow   |
| `make clean`| Clean up backups directory          |
| `make help` | Show available commands             |
| `make clear`| Clear the screen                    |

## Structure

```
.
├── configs/           # Configuration files and scripts
│   ├── scripts/      # Installation scripts
│   └── utils/        # Utility functions
├── dotfiles/         # Dotfiles managed by GNU Stow
│   ├── zsh/         # ZSH configuration
│   ├── nvim/        # Neovim configuration
│   └── tmux/        # Tmux configuration
├── packages/         # Package management
│   └── Brewfile     # Homebrew packages list
└── backups/         # Backup directory for existing configs
```

## Packages

The `Brewfile` includes:
- Modern CLI tools ([bat](https://github.com/sharkdp/bat), [eza](https://github.com/eza-community/eza), [fzf](https://github.com/junegunn/fzf), etc.)
- Development tools ([git](https://git-scm.com), [node](https://nodejs.org), [python](https://www.python.org), etc.)
- Shell enhancements ([zsh](https://www.zsh.org), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), etc.)
- And more...

## Dotfiles

Dotfiles are managed using [GNU Stow](https://www.gnu.org/software/stow/). The configuration includes:
- [ZSH](https://www.zsh.org) configuration with plugins
- [Neovim](https://neovim.io) setup
- [Tmux](https://github.com/tmux/tmux) configuration

### Powerlevel10k Configuration

If you use my `.zsh` dotfile, you'll need to run the Powerlevel10k configuration wizard to install required fonts and choose your preferred style:

```bash
p10k configure
```

This will guide you through the installation of the necessary fonts and allow you to customize the appearance of your terminal prompt.

## Backup

Before installing dotfiles, existing configurations are automatically backed up to the `backups` directory with a timestamp.

## Contributing

Feel free to fork this repository and customize it for your needs. Pull requests are welcome! 