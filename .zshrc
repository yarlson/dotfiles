#!/bin/zsh

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
    git
    nvm
    # zsh-autosuggestions
    # zsh-completions
    brew
    fzf
    thefuck
)

# Source Oh My Zsh
source "$ZSH/oh-my-zsh.sh"

# Environment variables
export EDITOR="vim"

# PATH configuration
export PATH="$HOME/go/bin:/usr/local/bin:/Users/yar/.local/bin:$PATH"

# Load custom aliases
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh

# Custom aliases
alias mc='mc --nosubshell'

# Zsh completion styles
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'

# Initialize zsh-completions
autoload -U compinit && compinit

# FZF configuration (if additional settings are needed)
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"


# pnpm
export PNPM_HOME="/Users/yar/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm endA

alias docker-compose="docker compose"
