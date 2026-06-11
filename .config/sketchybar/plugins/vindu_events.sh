#!/usr/bin/env bash

# Bridges vindu's event socket to sketchybar. vindu speaks Hyprland's
# socket2 wire format (EVENT>>DATA); `vinductl events` streams it. Reconnects
# forever so the bar survives daemon restarts.

VINDUCTL=/usr/local/bin/vinductl

while true; do
  "$VINDUCTL" events 2>/dev/null | while IFS= read -r line; do
    case "$line" in
      workspace\>\>*)
        sketchybar --trigger vindu_workspace_change FOCUSED_WORKSPACE="${line#workspace>>}"
        ;;
      focusedmon\>\>*)
        # focusedmon>>MONITOR,WORKSPACE — workspace is the last field
        sketchybar --trigger vindu_workspace_change FOCUSED_WORKSPACE="${line##*,}"
        ;;
    esac
  done
  sleep 2
done
