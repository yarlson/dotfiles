#!/usr/bin/env bash

sketchybar --add item clock right \
           --set clock update_freq=10 icon="$ICON_CLOCK" script="$PLUGIN_DIR/clock.sh"
