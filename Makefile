# =============================================================================
# Makefile for macOS Development Environment Setup
# =============================================================================

# Set default target
.DEFAULT_GOAL := magic

# Check if running on macOS
.PHONY: check-os
check-os:
	@bash configs/scripts/check_os.sh

# Install packages
.PHONY: install
install: check-os
	@bash packages/packages.sh

#install packages multiuser 
.PHONY: install-multiuser
install-multiuser: check-os
	@bash packages/packages.sh --multiuser

# Install dotfiles
.PHONY: dotfiles
dotfiles: check-os
	@bash configs/scripts/dotfiles.sh

# Clean up backups
.PHONY: clean
clean:
	@bash configs/scripts/clean.sh

# Show help
.PHONY: help
help:
	@bash configs/scripts/help.sh

# Clear screen
.PHONY: clear
clear:
	@clear

# Install everything
.PHONY: magic
magic: install dotfiles

# Install everything for multipleuser mac
.PHONY: magic-multiuser
magic-multiuser: install-multiuser dotfiles

# Declare all phony targets
.PHONY: magic check-os install install-multiuser dotfiles clean help clear 