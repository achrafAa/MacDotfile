#!/bin/bash

# =============================================================================
# Package Installation Script
# =============================================================================
# This script installs packages using Homebrew
# =============================================================================

# Define the default Homebrew installation location
BREW_PREFIX="/usr/local"

# Check if the script is called with the '--multiuser' parameter
if [ "$1" = "--multiuser" ]; then
  # Set the Homebrew installation location to a different directory
  BREW_PREFIX="$HOME/.brew"
fi

# Source utilities
source "$(dirname "$0")/../configs/utils/utils.sh"

# =============================================================================
# Functions
# =============================================================================

# Check if Homebrew is installed
check_homebrew() {
    if ! command_exists brew; then
        print_warning "Homebrew is not installed. Installing now..."
        
        # Install Homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" --prefix="$BREW_PREFIX" || {
            print_error "Failed to install Homebrew"
            print_status "Please install it manually from https://brew.sh"
            exit 1
        }
        
        # Add Homebrew to PATH for Apple Silicon Macs
        if [[ "$(uname -m)" == "arm64" ]]; then
            eval "$($BREW_PREFIX/bin/brew shellenv)" || {
                print_error "Failed to add Homebrew to PATH"
                exit 1
            }
        fi
    
        
        print_success "Homebrew installed successfully!"
    fi
    
    # Show Homebrew version
    print_table_row "Homebrew" "Installed" "$(brew --version | head -n 1)"
}

# Check if a package is installed
is_package_installed() {
    local package="$1"
    local is_cask="$2"
    
    if [ "$is_cask" = "true" ]; then
        brew list --cask "$package" &>/dev/null
    else
        brew list "$package" &>/dev/null
    fi
}

# Get package version
get_package_version() {
    local package="$1"
    local is_cask="$2"
    
    if [ "$is_cask" = "true" ]; then
        # For casks, try to get version from the app bundle
        local app_name=$(brew info --cask "$package" | grep -o ".*\.app" | head -n 1 | xargs basename 2>/dev/null)
        if [ -n "$app_name" ]; then
            local version=$(/usr/libexec/PlistBuddy -c "Print CFBundleShortVersionString" "/Applications/$app_name/Contents/Info.plist" 2>/dev/null)
            if [ -n "$version" ]; then
                echo "$version"
                return
            fi
        fi
        # Fallback to brew info
        brew info --cask "$package" | grep -o ".*: .*" | head -n 1 | cut -d: -f2 | tr -d ' '
    else
        # For regular packages, get version and clean it up
        local version=$(brew info "$package" | grep -o "stable.*" | head -n 1 | sed 's/stable//g' | tr -d ' ')
        # Remove (bottled) and HEAD from version
        echo "$version" | sed 's/(bottled)//g' | sed 's/,HEAD//g' | tr -d ' '
    fi
}

# Install all packages from Brewfile
install_all_packages() {
    local brewfile="$(dirname "$0")/Brewfile"
    
    if [ ! -f "$brewfile" ]; then
        print_error "Brewfile not found at $brewfile"
        exit 1
    fi
    
    print_header "PACKAGE INSTALLATION" "$BLUE" "$PACKAGE_ICON"
    print_table_header
    
    # Check if Homebrew is installed
    check_homebrew
    
    while IFS= read -r line || [ -n "$line" ]; do
        # Skip comments and empty lines
        [[ "$line" =~ ^#.*$ ]] && continue
        [[ -z "$line" ]] && continue
        
        # Parse package type and name
        if [[ "$line" =~ ^cask\ \"(.*)\"$ ]]; then
            package="${BASH_REMATCH[1]}"
            is_cask=true
        elif [[ "$line" =~ ^brew\ \"(.*)\"$ ]] || [[ "$line" =~ ^\"(.*)\"$ ]]; then
            package="${BASH_REMATCH[1]}"
            is_cask=false
        else
            continue
        fi
        
        # Check if package is already installed
        if is_package_installed "$package" "$is_cask"; then
            version=$(get_package_version "$package" "$is_cask")
            print_table_row "$package" "Installed" "$version"
        else
            print_table_row "$package" "Installing" "N/A"
            if [ "$is_cask" = "true" ]; then
                brew install --cask "$package" || print_table_row "$package" "Failed" "Installation failed"
            else
                brew install "$package" || print_table_row "$package" "Failed" "Installation failed"
            fi
        fi
    done < "$brewfile"
    
    print_success "Package installation complete"
}

# =============================================================================
# Main
# =============================================================================
install_all_packages 