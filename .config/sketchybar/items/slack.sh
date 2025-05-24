#!/bin/bash

slack=(
    updates=on
    update_freq=3
    icon=󰒱
    icon.drawing=on
    label.font="$FONT:Semibold:14.0"
    script="$PLUGIN_DIR/slack.sh"
    click_script="open -a Slack"
)

sketchybar --add item slack right        \
           --set slack "${slack[@]}"
