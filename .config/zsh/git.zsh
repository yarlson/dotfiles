wt() {
  local branch="$1"
  local RED="\033[31m"
  local GREEN="\033[32m"
  local RESET="\033[0m"
  local ERR="${RED}󰅖${RESET}"  
  local OK="${GREEN}${RESET}"

  [[ -z "$branch" ]] && echo "$ERR  Usage: wt <branch>" && return 1

  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    echo "$ERR  Not inside a Git repository."
    return 1
  }

  local dir="$root/.worktrees/$branch"
  mkdir -p "$root/.worktrees" || {
    echo "$ERR Failed to create .worktrees directory."
    return 1
  }

  git worktree add "$dir" -b "$branch" || {
    echo "$ERR Failed to create worktree for branch '$branch'."
    return 1
  }

  cd "$dir" || {
    echo "$ERR Failed to cd into '$dir'."
    return 1
  }

  echo "$OK  Worktree '$branch' created and switched to."
}

