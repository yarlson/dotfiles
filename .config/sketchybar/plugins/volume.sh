#!/usr/bin/env bash

source "$CONFIG_DIR/icons.sh"

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
    [6-9][0-9]|100) ICON="$ICON_VOLUME_HIGH" ;;
    [3-5][0-9])     ICON="$ICON_VOLUME_MED" ;;
    [1-9]|[1-2][0-9]) ICON="$ICON_VOLUME_LOW" ;;
    *)              ICON="$ICON_VOLUME_MUTE" ;;
  esac

  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
fi
