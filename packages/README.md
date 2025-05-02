# Package Management

This directory contains the Brewfile for managing packages using [Homebrew](https://brew.sh).

## Brewfile Contents

### CLI Tools
- [`bat`](https://github.com/sharkdp/bat) - A cat clone with syntax highlighting
- [`eza`](https://github.com/eza-community/eza) - Modern replacement for ls
- [`fzf`](https://github.com/junegunn/fzf) - Fuzzy finder
- [`fd`](https://github.com/sharkdp/fd) - Simple, fast alternative to find
- [`thefuck`](https://github.com/nvbn/thefuck) - Magnificent app which corrects your previous console command
- [`zoxide`](https://github.com/ajeetdsouza/zoxide) - Smarter cd command

### Shell
- [`zsh`](https://www.zsh.org) - Z shell
- [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions) - Fish-like autosuggestions for zsh
- [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting) - Fish shell-like syntax highlighting for zsh

### Development
- [`git`](https://git-scm.com) - Version control
- [`node`](https://nodejs.org) - Node.js
- [`python`](https://www.python.org) - Python programming language
- [`go`](https://go.dev) - Go programming language
- [`rust`](https://www.rust-lang.org) - Rust programming language
- [`php`](https://www.php.net) - PHP programming language

### Tools
- [`stow`](https://www.gnu.org/software/stow/) - Symlink farm manager
- [`orbstack`](https://orbstack.dev) - Docker Desktop alternative

## Usage

The packages are installed automatically when running:
```bash
make install
```

Or as part of the complete setup:
```bash
make magic
```

## Adding New Packages

To add new packages:
1. Edit the `Brewfile`
2. Add the package using the appropriate format:
   - Regular packages: `brew "package-name"`
   - Cask applications: `cask "app-name"`
3. Run `make install` to install the new packages

## Updating Packages

To update all packages:
```bash
  brew update;
  brew upgrade;
  for cask in $(brew list -1 --cask); do
     brew upgrade $cask;
  done;
``` 
