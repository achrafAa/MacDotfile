# Dotfiles

This directory contains all dotfiles and configuration files for various tools and applications.

## Structure

- `zsh/` - Zsh configuration files
  - `.zshrc`
  - `.zshenv`
  - Custom functions and aliases
- `tmux/` - Tmux configuration
  - `.tmux.conf`
  - Custom plugins and themes
- `nvim/` - Neovim configuration
  - `init.lua`
  - Custom plugins and settings

## Installation

Dotfiles are installed using GNU Stow:

```bash
stow zsh tmux nvim
```

This creates symbolic links in your home directory pointing to these configuration files. 