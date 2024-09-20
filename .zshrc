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
    asdf
    docker
    kubectl
    fzf
)

source "$ZSH/oh-my-zsh.sh"

# Environment variables
export EDITOR="vim"

# PATH configuration
export PATH="$HOME/go/bin:/usr/local/bin:/opt/homebrew/opt/go@1.21/bin:$HOME/.local/bin:$PATH"

# Load custom aliases
[[ -f ~/.config/zsh/aliases.zsh ]] && source ~/.config/zsh/aliases.zsh

# Aliases
# Git
alias g='git'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
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
alias n='npm'
alias ns='npm start'
alias nt='npm test'
alias ni='npm install'
alias nr='npm run'

# General
alias c='code .'
alias l='ls -lah'
alias mc='mc --nosubshell'

# Zsh completion styles
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-ipaddr:ip\ address hosts:-host:host files'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|?=** r:|?=**'

# Initialize zsh-completions
autoload -U compinit && compinit

# FZF configuration
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Go configuration
export GOPATH="$HOME/go"

# Kubectl autocomplete
source <(kubectl completion zsh)

# Docker compose completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i
