# Custom keybindings
# Loaded after atuin to override its arrow-key behavior

# Use native zsh prefix-filtered history for arrow keys
# (instead of atuin's up-search which is available via Ctrl+R)
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

# Apply to all keymaps for consistency
bindkey -M emacs '^[[A' up-line-or-beginning-search
bindkey -M emacs '^[[B' down-line-or-beginning-search
bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search
bindkey -M vicmd '^[[A' up-line-or-beginning-search
bindkey -M vicmd '^[[B' down-line-or-beginning-search
