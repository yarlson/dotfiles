#!/usr/bin/env bash

VINDUCTL=/usr/local/bin/vinductl

if [ ! -x "$VINDUCTL" ]; then
  return 0
fi

sketchybar --add event vindu_workspace_change

# Items exist even when the daemon is down (bar starts before vindud);
# the first workspace event corrects the highlight.
focused_workspace=$("$VINDUCTL" activeworkspace 2>/dev/null | head -1 | awk '{print $3}')
focused_workspace=${focused_workspace:-1}

for sid in 1 2 3 4 5 6 7 8 9; do
  if [ "$sid" = "$focused_workspace" ]; then
    background_color=$COLOR_SPACE_FOCUSED
  else
    background_color=$COLOR_SPACE_DEFAULT
  fi
  sketchybar --add item space.$sid left \
    --subscribe space.$sid vindu_workspace_change \
    --set space.$sid \
      background.color=$background_color \
      background.corner_radius=5 \
      background.height=20 \
      background.drawing=off \
      label="$sid" \
      click_script="$VINDUCTL dispatch workspace $sid" \
      script="$CONFIG_DIR/plugins/vindu.sh $sid"
done

# One event bridge per bar; reloads kill the previous instance.
pkill -f "plugins/vindu_events.sh" 2>/dev/null
nohup "$CONFIG_DIR/plugins/vindu_events.sh" >/dev/null 2>&1 &
