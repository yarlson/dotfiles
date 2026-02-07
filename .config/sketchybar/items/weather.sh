#!/usr/bin/env bash

sketchybar --add item weather right \
           --set weather \
             update_freq=1800 \
             script="$PLUGIN_DIR/weather.sh" \
             icon.font="$FONT:Regular:13.0" \
             click_script="open https://weather.com/weather/today/l/56.95,24.11?unit=m"
