# ~/.zshrc — main entry point
# Configuration files are loaded in order for proper override behavior

# Base configuration (PATH, history, completion, prompt)
source ~/.config/zsh/base.zsh

# Tool integrations
[[ -f ~/.config/zsh/atuin.zsh ]] && source ~/.config/zsh/atuin.zsh
[[ -f ~/.config/zsh/zoxide.zsh ]] && source ~/.config/zsh/zoxide.zsh

# Custom keybindings (must load after atuin to override arrow keys)
[[ -f ~/.config/zsh/keybindings.zsh ]] && source ~/.config/zsh/keybindings.zsh

# Optional overrides
HOST_FILE="$HOME/.config/zsh/host/$(hostname -s).zsh"
[[ -f "$HOST_FILE" ]] && source "$HOST_FILE"
[[ -f "$HOME/.config/zsh/local.zsh" ]] && source "$HOME/.config/zsh/local.zsh"
