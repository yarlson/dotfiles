#!/usr/bin/env bash

slack=(
  updates=on
  update_freq=10
  icon="$ICON_SLACK"
  icon.drawing=on
  label.font="$FONT:Semibold:14.0"
  script="$PLUGIN_DIR/slack.sh"
  click_script="open -a Slack"
)

sketchybar --add item slack right \
           --set slack "${slack[@]}"
