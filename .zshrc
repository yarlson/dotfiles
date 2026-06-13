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
export PATH="/Applications/GoLand.app/Contents/MacOS:$PATH"

# Added by Antigravity
export PATH="/Users/yaroslavk/.antigravity/antigravity/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

# opencode
export PATH=/Users/yaroslavk/.opencode/bin:$PATH

export PATH="$HOME/.bun/bin:$PATH"

# opencode
export PATH=/Users/yar/.opencode/bin:$PATH
alias no='curl -fsSL "https://raw.githubusercontent.com/hotheadhacker/no-as-a-service/refs/heads/main/reasons.json" | jq -r ".[]" | awk "BEGIN{srand()} {a[NR]=\$0} END{print a[1+int(rand()*NR)]}"'

# Colima Docker — make it behave like Docker Desktop
export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"
export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE="/var/run/docker.sock"
export TESTCONTAINERS_RYUK_DISABLED="false"

export CMT_PROVIDER=codex


# Claude Code dev sandbox — run in current dir, container named by path hash
alias sandbox='docker run -it --rm --name "claude-sandbox-$(pwd -P | shasum | cut -c1-8)" -v "$(pwd -P)":"$(pwd -P)" -w "$(pwd -P)" -v claude-sandbox-mise:/mise -v claude-sandbox-home:/root/.claude claude-sandbox claude --dangerously-skip-permissions --append-system-prompt-file /etc/claude-sandbox/instructions.md'
export PATH="$(brew --prefix libpq)/bin:$PATH"
