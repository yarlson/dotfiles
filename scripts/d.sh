#!/bin/bash

# Get the current working directory
CURRENT_DIR=$(pwd)

# Generate a session name based on the current directory name
SESSION_NAME=$(basename "$CURRENT_DIR" | tr '.' '_')

# Check if tmux is already running
if ! tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
	# Create a new tmux session with nvim in the first window
	tmux new-session -d -s "$SESSION_NAME" -c "$CURRENT_DIR"

	# Start nvim in the first window
	tmux send-keys -t "$SESSION_NAME":1 "nvim ." C-m

	# Create a second window for shell
	tmux new-window -t "$SESSION_NAME":2 -c "$CURRENT_DIR"

	# Select the nvim window (first window)
	tmux select-window -t "$SESSION_NAME":1
fi

# Attach to session focusing on nvim window
tmux attach -t "$SESSION_NAME"
