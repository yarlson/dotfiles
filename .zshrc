# shellcheck shell=bash disable=SC1090,SC1091
# ~/.zshrc — main entry point
# Configuration files are loaded in order for proper override behavior

# Base configuration (PATH, Go, completion, prompt)
source ~/.config/zsh/base.zsh

# History configuration (must load before keybindings)
[[ -f ~/.config/zsh/history.zsh ]] && source ~/.config/zsh/history.zsh

# Aliases and functions
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh

# Custom keybindings (must load after atuin to override arrow keys)
[[ -f ~/.config/zsh/keybindings.zsh ]] && source ~/.config/zsh/keybindings.zsh

# Optional overrides
HOST_FILE="$HOME/.config/zsh/host/$(hostname -s).zsh"
[[ -f "$HOST_FILE" ]] && source "$HOST_FILE"
[[ -f "$HOME/.config/zsh/local.zsh" ]] && source "$HOME/.config/zsh/local.zsh"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Added by Antigravity
export PATH="/Users/yaroslavk/.antigravity/antigravity/bin:$PATH"

export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
export DOCKER_HOST="unix://${HOME}/.colima/docker.sock"

export PATH="$HOME/.local/bin:$PATH"

# opencode
export PATH=/Users/yaroslavk/.opencode/bin:$PATH
