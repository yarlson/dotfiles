#!/usr/bin/env bash

SLIDER_WIDTH=150

volume_icon=(
  icon="$ICON_VOLUME_HIGH"
  icon.font="$FONT:Regular:17.0"
  label.drawing=off
  click_script="sketchybar --set \$NAME popup.drawing=toggle"
  popup.align=center
  popup.background.color=$COLOR_BAR_BG
  popup.background.corner_radius=9
  popup.background.border_width=2
  popup.background.border_color=$COLOR_SPACE_DEFAULT
  script="$PLUGIN_DIR/volume.sh"
)

volume_slider=(
  slider.highlight_color=$COLOR_GREEN
  slider.background.height=6
  slider.background.corner_radius=3
  slider.background.color=$COLOR_SPACE_DEFAULT
  slider.knob="$ICON_SLIDER_KNOB"
  slider.knob.drawing=on
  slider.knob.font="$FONT:Bold:16.0"
  slider.knob.color=$COLOR_WHITE
  background.color=$COLOR_BAR_BG
  background.height=2
  background.y_offset=-20
  click_script='osascript -e "set volume output volume $PERCENTAGE"'
)

sketchybar --add item volume right \
           --set volume "${volume_icon[@]}" \
           --subscribe volume volume_change mouse.scrolled mouse.exited.global \
           --add slider volume_slider popup.volume $SLIDER_WIDTH \
           --set volume_slider "${volume_slider[@]}" \
           --subscribe volume_slider mouse.clicked
