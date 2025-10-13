# --- Ensure writable TMPDIR ---
if [ -z "$TMPDIR" ] || [ ! -w "$TMPDIR" ]; then
  export TMPDIR="$HOME/tmp"
  mkdir -p "$TMPDIR"
  chmod 700 "$TMPDIR"
fi

# --- PATH setup ---
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/.local/bin:$HOME/go/bin:/usr/local/bin:$PATH"

# --- Go ---
export GOROOT="/opt/homebrew/opt/go/libexec"
export GOPATH="$HOME/go"

# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt hist_ignore_dups share_history

# --- Prefix-filtered ↑/↓ history search ---
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# --- FZF / completion setup ---
export FZF_DEFAULT_COMMAND='fd --hidden --strip-cwd-prefix --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --strip-cwd-prefix --exclude .git'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Compile zcompdump once per week for safety
autoload -Uz compinit
if [[ ! -s ~/.zcompdump || -n $(find ~/.zcompdump -mtime +7 2>/dev/null) ]]; then
  compinit -i
else
  compinit -C
fi

# --- Starship prompt ---
eval "$(starship init zsh)"

# --- Aliases ---
alias n='nvim'
alias z='zed'

# --- Editor ---
export EDITOR="nvim"
