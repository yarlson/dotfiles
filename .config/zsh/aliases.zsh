# shellcheck shell=bash disable=SC1090
# --- Aliases ---
alias n='nvim'
alias gol='golangci-lint run ./... --fix'
alias gou='go get -u ./... && go mod tidy'
alias cc='claude --dangerously-skip-permissions --permission-mode acceptEdits'
alias ccr='claude --dangerously-skip-permissions --permission-mode acceptEdits --resume'

__ide_tmux_layout() {
	local dir name cols lines created session left_pane right_pane right_width

	dir="$PWD"
	name="${dir##*/}"
	if [[ -n "$TMUX" ]]; then
		left_pane="$(tmux display-message -p '#{pane_id}')" || return
		tmux rename-window -t "$left_pane" "$name"
		cols="$(tmux display-message -p -t "$left_pane" '#{window_width}')" || return
		right_width=$(((cols - 21) / 2))
		((right_width < 20)) && right_width=20

		right_pane="$(tmux split-window -h -l "$right_width" -P -F '#{pane_id}' -c "$dir" -t "$left_pane" 'claude --dangerously-skip-permissions')" || return
		tmux resize-pane -t "$right_pane" -x "$right_width" 2>/dev/null
		tmux split-window -v -l 8 -c "$dir" -t "$left_pane" || return
		tmux send-keys -t "$left_pane" 'nvim .' C-m
		tmux select-pane -t "$right_pane"
		return
	fi

	cols="${COLUMNS:-$(tput cols 2>/dev/null || printf 120)}"
	lines="${LINES:-$(tput lines 2>/dev/null || printf 40)}"

	created="$(tmux new-session -d -x "$cols" -y "$lines" -n "$name" -P -F '#{session_id} #{pane_id}' -c "$dir" 'nvim .')" || return
	session="${created%% *}"
	left_pane="${created##* }"

	cols="$(tmux display-message -p -t "$left_pane" '#{window_width}')" || return
	right_width=$(((cols - 21) / 2))
	((right_width < 20)) && right_width=20

	right_pane="$(tmux split-window -h -l "$right_width" -P -F '#{pane_id}' -c "$dir" -t "$left_pane" 'claude --dangerously-skip-permissions')" || return
	tmux resize-pane -t "$right_pane" -x "$right_width" 2>/dev/null
	tmux split-window -v -l 8 -c "$dir" -t "$left_pane" || return
	tmux select-pane -t "$right_pane"

	tmux attach-session -t "$session"
}

alias ide='__ide_tmux_layout'

goland() {
	command goland "$@" >/dev/null 2>&1 &!
}

# --- Git Worktree Helper ---
wt() {
	local branch="$1"
	local RED="\033[31m"
	local GREEN="\033[32m"
	local RESET="\033[0m"
	local ERR="${RED}󰅖${RESET}"
	local OK="${GREEN}${RESET}"

	[[ -z "$branch" ]] && echo "$ERR  Usage: wt <branch>" && return 1

	local root
	root=$(git rev-parse --show-toplevel 2>/dev/null) || {
		echo "$ERR  Not inside a Git repository."
		return 1
	}

	local dir="$root/.worktrees/$branch"
	if [[ -d "$dir" ]]; then
		cd "$dir" || {
			echo "$ERR Failed to cd into '$dir'."
			return 1
		}

		echo "$OK  Switched to existing worktree '$branch'."
		return 0
	fi

	mkdir -p "$root/.worktrees" || {
		echo "$ERR Failed to create .worktrees directory."
		return 1
	}

	if git show-ref --verify --quiet "refs/heads/$branch"; then
		git worktree add "$dir" "$branch" || {
			echo "$ERR Failed to create worktree for existing branch '$branch'."
			return 1
		}
	else
		git worktree add "$dir" -b "$branch" || {
			echo "$ERR Failed to create worktree for branch '$branch'."
			return 1
		}
	fi

	cd "$dir" || {
		echo "$ERR Failed to cd into '$dir'."
		return 1
	}

	echo "$OK  Worktree '$branch' created and switched to."
}

wtr() {
	local RED="\033[31m"
	local GREEN="\033[32m"
	local RESET="\033[0m"
	local ERR="${RED}󰅖${RESET}"
	local OK="${GREEN}${RESET}"

	local current
	current=$(git rev-parse --show-toplevel 2>/dev/null) || {
		echo "$ERR  Not inside a Git repository."
		return 1
	}
	current=$(cd "$current" && pwd -P)

	local common_dir
	common_dir=$(git rev-parse --git-common-dir 2>/dev/null) || {
		echo "$ERR  Failed to resolve Git common directory."
		return 1
	}
	[[ "$common_dir" = /* ]] || common_dir="$current/$common_dir"

	local project_root
	project_root=$(cd "$common_dir/.." && pwd -P) || {
		echo "$ERR  Failed to resolve project root."
		return 1
	}

	if [[ "$current" == "$project_root" ]]; then
		echo "$ERR  Current directory is the main worktree; nothing to remove."
		return 1
	fi

	if [[ "$current" != "$project_root"/.worktrees/* ]]; then
		echo "$ERR  Current directory is not a managed worktree under '$project_root/.worktrees'."
		return 1
	fi

	if ! git -C "$project_root" worktree remove "$current"; then
		echo "$ERR  Failed to remove worktree '$current'."
		return 1
	fi

	cd "$project_root" || {
		echo "$ERR  Worktree removed, but failed to cd to '$project_root'."
		return 1
	}

	local worktrees_dir="$project_root/.worktrees"
	if [[ -d "$worktrees_dir" ]] && [[ -z "$(command ls -A "$worktrees_dir" 2>/dev/null)" ]]; then
		rmdir "$worktrees_dir" || {
			echo "$ERR  Worktree removed, but failed to delete empty '.worktrees' directory."
			return 1
		}
	fi

	echo "$OK  Removed current worktree and switched to '$project_root'."
}
