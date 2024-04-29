#!/bin/bash

slack=(
    updates=on
    update_freq=3
    icon.drawing=off
    label.font="$FONT:Semibold:14.0"
    script="$PLUGIN_DIR/slack.sh"
)

sketchybar --add item slack right        \
           --set slack "${slack[@]}"  \


