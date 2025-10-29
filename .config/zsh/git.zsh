wt() {
  local branch="$1"
  if [[ -z "$branch" ]]; then
    echo "Usage: wt <branch>"
    return 1
  fi

  # Find repo root
  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    echo "❌ Not inside a Git repository."
    return 1
  }

  local dir="$root/.worktrees/$branch"

  mkdir -p "$root/.worktrees"

  # Create worktree
  git worktree add "$dir" -b "$branch"
}

