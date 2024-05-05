#!/bin/bash

notification_count=(
    updates=on
    update_freq=3
    icon=󰯪
    icon.drawing=on
    label.font="$FONT:Semibold:14.0"
    script="$PLUGIN_DIR/notification_count.sh"
)

sketchybar --add item notification_count right        \
           --set notification_count "${notification_count[@]}"

