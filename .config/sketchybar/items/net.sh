#!/usr/bin/env bash

sketchybar --add item net right \
           --set net \
             script="$PLUGIN_DIR/net.sh" \
             updates=on \
             icon.font="SF Pro:Regular:17.0" \
             label.drawing=off \
           --subscribe net wifi_change
