# shellcheck shell=bash disable=SC1090
# --- PATH setup ---
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.local/bin:$HOME/go/bin:/usr/local/bin:$PATH"

# --- Go ---
export GOROOT="/opt/homebrew/opt/go/libexec"
export GOPATH="$HOME/go"

# --- Tool initialization ---
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"

# --- FZF / completion setup ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Re-bind Ctrl+R to atuin (FZF overrides it above)
bindkey '^r' atuin-search

# --- Completion ---
# Compile zcompdump once per week for performance
autoload -Uz compinit
if [[ ! -s ~/.zcompdump || -n $(find ~/.zcompdump -mtime +7 2>/dev/null) ]]; then
	compinit -i
else
	compinit -C
fi

# --- Starship prompt ---
eval "$(starship init zsh)"

# --- Editor ---
export EDITOR="nvim"
