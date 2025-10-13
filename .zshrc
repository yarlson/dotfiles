# ~/.zshrc — main entry point

# --- Base config ---
source ~/.zsh/base.zsh

# --- Host-specific config ---
HOST_FILE="$HOME/.zsh/host/$(hostname -s).zsh"
[[ -f "$HOST_FILE" ]] && source "$HOST_FILE"

# --- Local overrides (optional) ---
[[ -f "$HOME/.zsh/local.zsh" ]] && source "$HOME/.zsh/local.zsh"
