# --- Development tmux layout ---
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
