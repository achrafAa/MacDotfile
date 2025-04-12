#!/bin/bash

# =============================================================================
# Color and Icon Definitions
# =============================================================================
# Force color output
export FORCE_COLOR=1
export TERM=xterm-256color

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Icons
CHECK_MARK="${GREEN}✓${NC}"
CROSS_MARK="${RED}✗${NC}"
WARNING_MARK="${YELLOW}⚠${NC}"
INFO_MARK="${BLUE}ℹ${NC}"
ROCKET_ICON="${PURPLE}🚀${NC}"
GEAR_ICON="${CYAN}⚙${NC}"
DOWNLOAD_ICON="${YELLOW}⬇${NC}"
SUCCESS_ICON="${GREEN}✅${NC}"
ERROR_ICON="${RED}❌${NC}"
LOADING_ICON="${BLUE}⏳${NC}"
COMPLETE_ICON="${GREEN}🎉${NC}"
TERMINAL_ICON="${PURPLE}🖥${NC}"
COLOR_ICON="${CYAN}🎨${NC}"
SETTINGS_ICON="${BLUE}⚙${NC}"
SKIP_ICON="${BLUE}⏭${NC}"
MISSING_ICON="${RED}❌${NC}"
FOLDER_ICON="${PURPLE}📁${NC}"
LINK_ICON="${CYAN}🔗${NC}"
BACKUP_ICON="${YELLOW}💾${NC}"
INSTALL_ICON="${GREEN}⚙${NC}"
PACKAGE_ICON="${BLUE}📦${NC}"
DOTFILE_ICON="${YELLOW}🔧${NC}"
ITERM_ICON="${PURPLE}🖥️${NC}"

# =============================================================================
# Helper Functions
# =============================================================================
# Print a section header
print_header() {
    local title="$1"
    local color="$2"
    local icon="$3"
    
    printf "\n${BOLD}${color}${icon} %s${NC}\n\n" "$title"
}

# Print a status message
print_status() {
    printf "${INFO_MARK} ${BLUE}%s${NC}\n" "$1"
}

# Print a success message
print_success() {
    printf "${CHECK_MARK} ${GREEN}%s${NC}\n" "$1"
}

# Print an error message
print_error() {
    printf "${ERROR_ICON} ${RED}%s${NC}\n" "$1"
}

# Print a warning message
print_warning() {
    printf "${WARNING_MARK} ${YELLOW}%s${NC}\n" "$1"
}

# Print a loading message
print_loading() {
    printf "${LOADING_ICON} ${CYAN}%s${NC}\n" "$1"
}

# Print a table header
print_table_header() {
    local task_type="${1:-packages}"
    
    case "$task_type" in
        "packages")
            printf "\nPackage                                   Status              Version\n"
            printf "────────────────────────────────────────────────────────────────────────\n"
            ;;
        "dotfiles")
            printf "\nPackage                                   Status\n"
            printf "────────────────────────────────────────────────────────────────────────\n"
            ;;
        "iterm2")
            printf "\nComponent                                 Status              \n"
            printf "────────────────────────────────────────────────────────────────────────\n"
            ;;
    esac
}

# Print a table row
print_table_row() {
    local item="$1"
    local status="$2"
    local action="$3"
    local task_type="${4:-packages}"
    
    case "$status" in
        "Installed")
            printf "%-40s ✓ \033[32mInstalled\033[0m %15s\n" "$item" "$action"
            ;;
        "Installing")
            printf "%-40s ⏳ \033[33mInstalling\033[0m %15s\n" "$item" "$action"
            ;;
        "Failed")
            printf "%-40s ❌ \033[31m%s\033[0m\n" "$item" "$action"
            ;;
        "Creating")
            printf "%-40s 📝 \033[36mCreating\033[0m %15s\n" "$item" "$action"
            ;;
        "Success")
            printf "%-40s ✓ \033[32mSuccess\033[0m %15s\n" "$item" "$action"
            ;;
        "Missing")
            printf "%-40s ❗ \033[31mMissing\033[0m %15s\n" "$item" "$action"
            ;;
        "Found")
            printf "%-40s ✓ \033[32mFound\033[0m %15s\n" "$item" "$action"
            ;;
        "Running")
            printf "%-40s ✓ \033[32mRunning\033[0m %15s\n" "$item" "$action"
            ;;
        "Applying")
            printf "%-40s ⚙️  \033[36mApplying\033[0m %15s\n" "$item" "$action"
            ;;
        *)
            printf "%-40s ℹ \033[34m%s\033[0m %15s\n" "$item" "$status" "$action"
            ;;
    esac
}

# Print table footer - empty since we don't need it anymore
print_table_footer() {
    :
}

# Create a backup of a file
backup_file() {
    local file="$1"
    local backup_dir="$2"
    
    if [ -e "$file" ]; then
        mkdir -p "$backup_dir"
        cp -R "$file" "$backup_dir/" 2>/dev/null
        return $?
    fi
    
    return 0
}

# Check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Check if running on macOS
is_macos() {
    [[ "$OSTYPE" == "darwin"* ]]
} 