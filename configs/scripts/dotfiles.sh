#!/bin/bash

# =============================================================================
# Dotfiles Installation Script
# =============================================================================
# This script installs dotfiles using GNU Stow
# =============================================================================

# Source utils
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../utils/utils.sh"

# Set dotfiles directory
DOTFILES_DIR="$(cd "$SCRIPT_DIR/../../dotfiles" && pwd)"
DOTFILES_LIST="$DOTFILES_DIR/dotfiles_list.conf"

# =============================================================================
# Functions
# =============================================================================

# Check if dotfiles are installed
is_dotfiles_installed() {
    local folder="$1"
    local target="$2"
    
    # Check if the target file exists and is a symlink
    if [ -L "$target" ]; then
        # Check if the symlink points to our dotfiles
        local link_target=$(readlink "$target")
        if [[ "$link_target" == *"$folder"* ]]; then
            return 0
        fi
    fi
    
    return 1
}

# Backup existing dotfiles
backup_dotfiles() {
    local folder="$1"
    local target="$2"
    local backup_dir="$3"
    
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        mkdir -p "$backup_dir"
        cp -R "$target" "$backup_dir/" 2>/dev/null
        return $?
    fi
    
    return 0
}

install_zsh_plugins() {
    print_header "🔌 Installing ZSH plugins"
    local install_success=0
    
    # Install powerlevel10k
    if ! brew list powerlevel10k &>/dev/null; then
        print_table_row "powerlevel10k" "Installing" "via Homebrew"
        if ! brew install powerlevel10k; then
            print_table_row "powerlevel10k" "Failed" "Installation error"
            install_success=1
        else
            print_table_row "powerlevel10k" "Installed" "✓"
        fi
    else
        print_table_row "powerlevel10k" "Installed" "✓"
    fi

    # Install fzf-git.sh
    if [ ! -d "$HOME/fzf-git.sh" ]; then
        print_table_row "fzf-git.sh" "Installing" "via Git"
        if ! git clone https://github.com/junegunn/fzf-git.sh.git "$HOME/fzf-git.sh"; then
            print_table_row "fzf-git.sh" "Failed" "Installation error"
            install_success=1
        else
            print_table_row "fzf-git.sh" "Installed" "✓"
        fi
    else
        print_table_row "fzf-git.sh" "Installed" "✓"
    fi

    # Fix permissions for ZSH completions
    if compaudit &>/dev/null; then
        compaudit | xargs chmod g-w 2>/dev/null || true
    fi

    return $install_success
}

install_dotfiles() {
    print_header "🔧 Installing dotfiles"
    
    # Read dotfiles list and filter out comments and empty lines
    local dotfiles=($(grep -v '^#' "$DOTFILES_LIST" | grep -v '^[[:space:]]*$'))
    
    # Check if ZSH is in the list
    if printf '%s\n' "${dotfiles[@]}" | grep -q '^zsh$'; then
        # Install ZSH plugins first if zsh is in the list
        if ! install_zsh_plugins; then
            print_error "Failed to install some ZSH plugins. Please check the errors above."
            return 1
        fi
    fi
    
    # Stow each dotfile in the list
    for dotfile in "${dotfiles[@]}"; do
        print_table_row "$dotfile" "Installing" "via GNU Stow"
        if ! (cd "$DOTFILES_DIR" && stow --target="$HOME" "$dotfile"); then
            print_table_row "$dotfile" "Failed" "Stow error"
            return 1
        fi
        print_table_row "$dotfile" "Installed" "✓"
    done
}

# =============================================================================
# Main
# =============================================================================
install_dotfiles || exit 1 