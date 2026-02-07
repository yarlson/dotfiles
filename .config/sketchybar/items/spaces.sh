#!/usr/bin/env bash

if ! command -v aerospace &>/dev/null; then
  return 0
fi

sketchybar --add event aerospace_workspace_change

focused_workspace=$(aerospace list-workspaces --focused 2>/dev/null)

for sid in $(aerospace list-workspaces --all 2>/dev/null); do
  if [ "$sid" = "$focused_workspace" ]; then
    background_color=$COLOR_SPACE_FOCUSED
  else
    background_color=$COLOR_SPACE_DEFAULT
  fi
  sketchybar --add item space.$sid left \
    --subscribe space.$sid aerospace_workspace_change \
    --set space.$sid \
      background.color=$background_color \
      background.corner_radius=5 \
      background.height=20 \
      background.drawing=off \
      label="$sid" \
      click_script="aerospace workspace $sid" \
      script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done
