#!/bin/bash

# =============================================================================
# OS Check Script
# =============================================================================
# This script checks if the system is running macOS
# =============================================================================

# Source utilities
source "$(dirname "$0")/../utils/utils.sh"

# Check if running on macOS
check_os() {
    if [[ "$(uname)" != "Darwin" ]]; then
        print_error "This script only works on macOS"
        exit 1
    fi
}

# =============================================================================
# Main
# =============================================================================
check_os 