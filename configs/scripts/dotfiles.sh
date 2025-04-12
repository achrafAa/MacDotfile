#!/bin/bash

# =============================================================================
# Dotfiles Installation Script
# =============================================================================
# This script installs dotfiles using GNU Stow
# =============================================================================

# Source utilities
source "$(dirname "$0")/../utils/utils.sh"

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

# Install dotfiles using GNU Stow
install_dotfiles() {
    local dotfiles_dir="$(dirname "$0")/../../dotfiles"
    local config_file="$dotfiles_dir/dotfiles_list.conf"
    local backup_dir="$(dirname "$0")/../../backups/$(date +%Y%m%d_%H%M%S)"
    
    # Check if dotfiles directory exists
    if [ ! -d "$dotfiles_dir" ]; then
        print_error "Dotfiles directory not found at $dotfiles_dir"
        exit 1
    fi
    
    # Check if config file exists
    if [ ! -f "$config_file" ]; then
        print_error "Dotfiles configuration file not found at $config_file"
        exit 1
    fi
    
    # Check if stow is installed
    if ! command -v stow >/dev/null 2>&1; then
        print_error "GNU Stow is not installed. Please install it first with 'brew install stow'"
        exit 1
    fi
    
    print_header "DOTFILES INSTALLATION" "$BLUE" "$DOTFILE_ICON"
    print_table_header "dotfiles"
    
    # Process each line in the config file
    while IFS= read -r line || [ -n "$line" ]; do
        # Skip comments and empty lines
        [[ "$line" =~ ^#.*$ ]] && continue
        [[ -z "$line" ]] && continue
        
        # Extract folder name
        folder="$line"
        target="$HOME/.$folder"
        
        # Check if already installed
        if is_dotfiles_installed "$folder" "$target"; then
            print_table_row "$folder" "Installed" "Already installed"
            continue
        fi
        
        # Backup existing dotfiles
        if backup_dotfiles "$folder" "$target" "$backup_dir"; then
            print_table_row "$folder" "Creating" "Backup created"
        else
            print_table_row "$folder" "Creating" "No backup needed"
        fi
        
        # Create symlink
        if [ -d "$dotfiles_dir/$folder" ]; then
            # Force stow to adopt and override everything
            output=$(stow --adopt --override='.*' -v -t "$HOME" -d "$dotfiles_dir" "$folder" 2>&1 && \
                    stow --restow --override='.*' -v -t "$HOME" -d "$dotfiles_dir" "$folder" 2>&1)
            if [ $? -eq 0 ]; then
                print_table_row "$folder" "Success" "Created symlinks"
            else
                print_table_row "$folder" "Failed" "$output"
                print_error "Failed to stow $folder. Error: $output"
            fi
        else
            print_table_row "$folder" "Missing" "Folder not found in $dotfiles_dir"
        fi
    done < "$config_file"
    
    print_success "Dotfiles installation complete"
}

# =============================================================================
# Main
# =============================================================================
install_dotfiles 