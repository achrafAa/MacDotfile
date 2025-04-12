#!/bin/bash

# =============================================================================
# Cleanup Script
# =============================================================================

# Source utilities
source "$(dirname "$0")/../utils/utils.sh"

# Clean up backups
clean_backups() {
    print_header "CLEANUP" "$YELLOW" "$BACKUP_ICON"
    print_table_header
    
    local backup_dir="$(dirname "$0")/../../backups"
    
    if [ -d "$backup_dir" ]; then
        print_table_row "Backups" "Found" "Directory exists"
        rm -rf "$backup_dir"/* || true
        print_table_row "Backups" "Success" "Directory cleaned"
        print_success "Cleanup complete"
    else
        print_table_row "Backups" "Missing" "Directory not found"
        print_warning "No backups to clean"
    fi
}

# =============================================================================
# Main
# =============================================================================
clean_backups 