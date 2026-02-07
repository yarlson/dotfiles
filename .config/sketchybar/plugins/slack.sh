#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

SLACK_INFO=$(lsappinfo info -only StatusLabel "$(lsappinfo find LSDisplayName=Slack)")
COUNT=$(echo "$SLACK_INFO" | awk -F'"label"="' '{print $2}' | awk -F'"' '{print $1}')

LABEL_COLOR=$COLOR_WHITE

case "$COUNT" in
""|"\"")
  DRAWING=off
  ;;
"•")
  DRAWING=on
  ;;
*)
  DRAWING=on
  LABEL_COLOR=$COLOR_GREEN
  ;;
esac

sketchybar --set "$NAME" icon.color="$LABEL_COLOR" label.color="$LABEL_COLOR" drawing="$DRAWING" label="$COUNT"
