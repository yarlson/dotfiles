# shellcheck shell=bash disable=SC1090
# --- PATH setup ---
typeset -U path PATH
path=(
	/opt/homebrew/opt/libpq/bin
	"$HOME/.opencode/bin"
	"$HOME/.bun/bin"
	"$HOME/.local/bin"
	/Applications/GoLand.app/Contents/MacOS
	/opt/homebrew/opt/llvm/bin
	/opt/homebrew/bin
	/opt/homebrew/sbin
	"$HOME/go/bin"
	/usr/local/bin
	$path
)
export PATH

# --- Go ---
export GOROOT="/opt/homebrew/opt/go/libexec"
export GOPATH="$HOME/go"

# --- Tool defaults ---
export CMT_PROVIDER=codex

# --- Tool initialization ---
eval "$(mise activate zsh)"
eval "$(atuin init zsh)"
eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"

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
