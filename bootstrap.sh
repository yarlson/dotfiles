#!/bin/bash

set -e  # Exit on any error

echo "🚀 Setting up zsh and tmux plugins..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

log_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

log_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

# Install Oh My Zsh
install_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        log_success "Oh My Zsh installed"
    else
        log_success "Oh My Zsh already installed"
    fi
}

# Install Zsh plugins
install_zsh_plugins() {
    local zsh_custom="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    # zsh-autosuggestions
    if [[ ! -d "$zsh_custom/plugins/zsh-autosuggestions" ]]; then
        log_info "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_custom/plugins/zsh-autosuggestions"
        log_success "zsh-autosuggestions installed"
    else
        log_success "zsh-autosuggestions already installed"
    fi

    # zsh-completions
    if [[ ! -d "$zsh_custom/plugins/zsh-completions" ]]; then
        log_info "Installing zsh-completions..."
        git clone https://github.com/zsh-users/zsh-completions "$zsh_custom/plugins/zsh-completions"
        log_success "zsh-completions installed"
    else
        log_success "zsh-completions already installed"
    fi
}

# Create custom completion directory
setup_completions() {
    log_info "Setting up custom completions directory..."
    mkdir -p "$HOME/.zsh/completions"
    log_success "Completions directory created"
}

# Install Tmux Plugin Manager (TPM)
install_tmux_tpm() {
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        log_info "Installing Tmux Plugin Manager..."
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
        log_success "TPM installed"
    else
        log_success "TPM already installed"
    fi
}

# Main installation flow
main() {
    echo "🎯 Setting up shell and tmux plugins..."

    install_oh_my_zsh
    install_zsh_plugins
    setup_completions
    install_tmux_tpm

    log_success "🎉 Plugin setup completed!"
}

# Run main function
main "$@"
