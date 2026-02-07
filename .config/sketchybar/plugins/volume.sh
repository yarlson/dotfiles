#!/usr/bin/env bash

source "$CONFIG_DIR/icons.sh"

IDLE_TIMEOUT=5
STAMP_FILE="/tmp/sketchybar_volume_stamp"

volume_icon() {
  local vol=$1
  case "$vol" in
    [6-9][0-9]|100) echo "$ICON_VOLUME_HIGH" ;;
    [3-5][0-9])     echo "$ICON_VOLUME_MED" ;;
    [1-9]|[1-2][0-9]) echo "$ICON_VOLUME_LOW" ;;
    *)              echo "$ICON_VOLUME_MUTE" ;;
  esac
}

schedule_dismiss() {
  local stamp=$EPOCHSECONDS
  echo "$stamp" > "$STAMP_FILE"
  (
    sleep "$IDLE_TIMEOUT"
    if [[ -f "$STAMP_FILE" && "$(cat "$STAMP_FILE")" == "$stamp" ]]; then
      sketchybar --set volume popup.drawing=off
    fi
  ) &
}

case "$SENDER" in
  "volume_change")
    VOLUME="$INFO"
    ICON=$(volume_icon "$VOLUME")
    sketchybar --set volume icon="$ICON" \
               --set volume_slider slider.percentage="$VOLUME"
    schedule_dismiss
    ;;

  "mouse.scrolled")
    CURRENT=$(osascript -e "output volume of (get volume settings)")
    NEW=$((CURRENT + SCROLL_DELTA * 5))
    if [ "$NEW" -gt 100 ]; then NEW=100; fi
    if [ "$NEW" -lt 0 ]; then NEW=0; fi
    osascript -e "set volume output volume $NEW"
    schedule_dismiss
    ;;

  "mouse.exited.global")
    sketchybar --set volume popup.drawing=off
    ;;
esac
