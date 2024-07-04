# Check if running on macOS and set the path for Homebrew and other macOS-specific settings
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH" # Homebrew path on macOS (M1/M2 chips)
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
    export PATH="/opt/homebrew/opt/php@8.2/bin:/opt/homebrew/opt/php@8.2/sbin:$PATH"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git nvm node zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Generic PATH
export PATH="$HOME/go/bin:/usr/local/bin:$PATH"

export EDITOR="vim"

# Function to find and add node_modules binary to PATH
add_local_node_modules() {
  CURRENT_DIR=$(pwd)

  while [[ "$CURRENT_DIR" != "" && "$CURRENT_DIR" != "/" ]]; do
    if [[ -d "$CURRENT_DIR/node_modules/.bin" ]]; then
      PATH="$CURRENT_DIR/node_modules/.bin:$PATH"
      break
    fi

    CURRENT_DIR=$(dirname "$CURRENT_DIR")
  done
}

preexec_functions+=add_local_node_modules

source ~/.config/zsh/aliases.zsh

alias s='ssh'
alias mc='mc --nosubshell'

# Highlight the current autocomplete option
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Better SSH/Rsync/SCP Autocomplete
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'

# Allow for autocomplete to be case insensitive
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
  '+l:|?=** r:|?=**'

# Initialize the autocompletion
autoload -Uz compinit && compinit -i

export NVM_DIR="$HOME/.nvm"

eval $(thefuck --alias)
eval "$(fzf --zsh)"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

export PATH="/opt/homebrew/opt/go@1.20/bin:$PATH"
