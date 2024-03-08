if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git nvm node nix-shell)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH="~/go/bin:$PATH"
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

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
. "$HOME/.cargo/env"
. "$HOME/.acme.sh/acme.sh.env"

source ~/.config/zsh/aliases.zsh

