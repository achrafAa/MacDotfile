# MacDotfile

[![macOS](https://img.shields.io/badge/macOS-13.0+-blue.svg)](https://www.apple.com/macos)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Homebrew](https://img.shields.io/badge/Homebrew-4.0+-orange.svg)](https://brew.sh)
[![GNU Stow](https://img.shields.io/badge/GNU%20Stow-2.3+-purple.svg)](https://www.gnu.org/software/stow/)
[![ZSH](https://img.shields.io/badge/ZSH-5.8+-red.svg)](https://www.zsh.org)
[![Neovim](https://img.shields.io/badge/Neovim-0.9+-green.svg)](https://neovim.io)
[![Tmux](https://img.shields.io/badge/Tmux-3.3+-blue.svg)](https://github.com/tmux/tmux)

This repository contains scripts and configurations to set up a development environment on macOS.

⚠️ **Important Warning**
> Since this project uses GNU Stow to create symbolic links, **DO NOT** remove or move the repository folder after installation. Doing so will break all symlinks to your dotfiles. If you need to move the repository:
> 1. Run `make clean` first
> 2. Move the folder
> 3. Run `make dotfiles` again

## Features

- 📦 Automated package installation via [Homebrew](https://brew.sh)
- 🔧 Dotfiles management using [GNU Stow](https://www.gnu.org/software/stow/)
- 🔄 Automatic backup of existing configurations
- ✨ Modern command-line tools and utilities

## Prerequisites

Before you begin, ensure you have:
- macOS
- [Git](https://git-scm.com)

[Homebrew](https://brew.sh) will be automatically installed if not found.

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

### Core CLI Tools
- [bat](https://github.com/sharkdp/bat) - A cat clone with syntax highlighting
- [eza](https://github.com/eza-community/eza) - Modern replacement for ls
- [fzf](https://github.com/junegunn/fzf) - Fuzzy finder
- [fd](https://github.com/sharkdp/fd) - Simple, fast alternative to find
- [thefuck](https://github.com/nvbn/thefuck) - Magnificent app which corrects your previous console command
- [zoxide](https://github.com/ajeetdsouza/zoxide) - Smarter cd command
- [stow](https://www.gnu.org/software/stow/) - Symlink farm manager

### Shell & Terminal
- [zsh](https://www.zsh.org) - Z shell
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Fish-like autosuggestions for zsh
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - Fish shell-like syntax highlighting
- [nvm](https://github.com/nvm-sh/nvm) - Node Version Manager

### Programming Languages
- [node](https://nodejs.org) - Node.js JavaScript runtime
- [python](https://www.python.org) - Python programming language
- [go](https://go.dev) - Go programming language
- [rust](https://www.rust-lang.org) - Rust programming language
- [php](https://www.php.net) - PHP programming language

### Applications
- [orbstack](https://orbstack.dev) - Fast, light, and simple Docker desktop alternative
- [iterm2](https://iterm2.com) - Terminal emulator for macOS

Each package is carefully selected to enhance your development workflow. You can customize the package list by editing the `Brewfile`.

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

## Configuration Files

### Brewfile (`packages/Brewfile`)

The `Brewfile` is a configuration file that defines all packages to be installed via Homebrew. Think of it as a shopping list for your development tools:

```brewfile
# Core utilities
brew "bat"      # Regular package installation
brew "eza"      # Regular package installation
cask "iterm2"   # macOS application installation
```

To modify your package list:
1. Edit `packages/Brewfile`
2. Add packages using:
   - `brew "package-name"` for CLI tools and libraries
   - `cask "app-name"` for macOS applications
3. Run `make install` to install new packages

### Dotfiles List (`dotfiles/dotfiles_list.conf`)

The `dotfiles_list.conf` tells Stow which dotfile folders to symlink to your home directory:

```conf
# Shell Configuration
zsh            # Will symlink dotfiles/zsh/.* to ~/.* 

# Vim Configuration
nvim          # Will symlink dotfiles/nvim/.* to ~/.* 

# tmux Configuration
tmux          # Will symlink dotfiles/tmux/.* to ~/.* 
```

To manage your dotfiles:
1. Add your configuration files to the appropriate folder in `dotfiles/`
2. Ensure the folder is listed in `dotfiles_list.conf`
3. Run `make dotfiles` to create the symlinks

⚠️ **Note**: Keep the folder structure in your dotfiles directory matching the structure you want in your home directory. For example:
- `dotfiles/zsh/.zshrc` → `~/.zshrc`
- `dotfiles/nvim/.config/nvim/init.lua` → `~/.config/nvim/init.lua`

## Contributing

Feel free to fork this repository and customize it for your needs. Pull requests are welcome! 