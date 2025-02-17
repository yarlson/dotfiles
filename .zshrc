# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/yar/.zsh/completions:"* ]]; then export FPATH="/Users/yar/.zsh/completions:$FPATH"; fi
# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Plugins
plugins=(
    git
    node
    zsh-autosuggestions
    zsh-completions
    brew
    docker
    kubectl
    fzf
)

source "$ZSH/oh-my-zsh.sh"

# Environment variables
export EDITOR="nvim"

# Go configuration
export GOROOT="/opt/homebrew/opt/go/libexec"
export GOPATH="$HOME/go"
export PATH="$PATH:$HOME/.local/bin:$GOPATH/bin:$GOROOT/bin:/usr/local/bin"

# Load custom aliases
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh

# Aliases

alias n='nvim'

# Git
alias g='git'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpf='git push --force'
alias gpr='git pull -r'
alias gl='git log --oneline'
alias gs='git status'

# Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias di='docker images'

# Kubernetes
alias k='kubectl'
alias ka='kubectl apply -f'
alias kd='kubectl delete -f'
alias kl='kubectl logs'
alias kx='kubectl exec -it'
alias kg='kubectl get'

# Node.js
alias np='npm'
alias ns='npm start'
alias nt='npm test'
alias ni='npm install'
alias nr='npm run'

# General
alias c='code .'
alias l='ls -lah'
alias mc='mc --nosubshell'

# Editor
alias z='zed "$1"'

# LLM usage
alias fix='f() { llm -m claude-3.5-sonnet -s "You are a grammar correction assistant. Return only corrected sentences without explanations, focusing on improving grammar, word choice, word order, and verb tenses." "$1"; }; f'
alias jira='function _jira() { llm -m claude-3.5-sonnet -s "$(cat ~/prompts/prompts/development/jira.txt)" "$1"; }; _jira'

# Zsh completion styles
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'

# Set fpath for custom completions
fpath=(~/.zsh/completion $fpath)

# Autoload compinit
autoload -U compinit

# Initialize kubectl completion
if type kubectl &>/dev/null; then
    source <(kubectl completion zsh)
    # Add completion for alias 'k'
    compdef __start_kubectl k
fi

# Initialize compinit
compinit -i

# FZF configuration
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export CGO_CFLAGS="-I/opt/homebrew/opt/sqlite/include"
export CGO_LDFLAGS="-L/opt/homebrew/opt/sqlite/lib"

# NVM
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# gpg
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

