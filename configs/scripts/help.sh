#!/bin/bash

# =============================================================================
# Help Script
# =============================================================================

# Source utilities
source "$(dirname "$0")/../utils/utils.sh"

# Show help
show_help() {
    print_header "AVAILABLE COMMANDS" "$BLUE" "$INFO_MARK"
    print_table_header
    
    print_table_row "magic" "Command" "Install everything (packages and dotfiles)"
    print_table_row "install" "Command" "Install packages using Homebrew"
    print_table_row "dotfiles" "Command" "Install dotfiles using GNU Stow"
    print_table_row "clean" "Command" "Clean up backups directory"
    print_table_row "help" "Command" "Show this help message"
    print_table_row "clear" "Command" "Clear the screen"
    
    print_success "Use 'make <command>' to run a command"
}

# =============================================================================
# Main
# =============================================================================
show_help 