# shellcheck shell=bash disable=SC2034
# --- History Configuration ---
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt hist_ignore_dups share_history

# --- Prefix-filtered history search (setup) ---
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
