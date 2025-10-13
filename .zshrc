# ~/.zshrc — main entry point

# --- Base config ---
source ~/.config/zsh/base.zsh

# --- Host-specific config ---
HOST_FILE="$HOME/.config/zsh/host/$(hostname -s).zsh"
[[ -f "$HOST_FILE" ]] && source "$HOST_FILE"

# --- Local overrides (optional) ---
[[ -f "$HOME/.config/zsh/local.zsh" ]] && source "$HOME/.config/zsh/local.zsh"
