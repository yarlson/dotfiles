#!/usr/bin/env bash

# Highlights the focused workspace item. FOCUSED_WORKSPACE arrives from the
# vindu_workspace_change event fired by plugins/vindu_events.sh.

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
	sketchybar --set "$NAME" background.drawing=on
else
	sketchybar --set "$NAME" background.drawing=off
fi
