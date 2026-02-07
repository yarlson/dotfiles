#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

# When switching between devices, it's possible to get hit with multiple
# concurrent events, some of which may occur before scutil picks up the
# changes, resulting in race conditions.
sleep 1

services=$(networksetup -listnetworkserviceorder)
device=$(scutil --nwi | sed -n "s/.*Network interfaces: \([^ ,]*\).*/\1/p")

test -n "$device" && service=$(echo "$services" \
  | sed -n "s/.*Hardware Port: \([^,]*\), Device: $device.*/\1/p")

color=$COLOR_WHITE
case $service in
  "iPhone USB")         icon=$ICON_NET_USB ;;
  "Thunderbolt Bridge") icon=$ICON_NET_THUNDERBOLT ;;

  Wi-Fi)
    if ipconfig getifaddr "$device" &>/dev/null; then
      icon=$ICON_NET_WIFI
    else
      icon=$ICON_NET_DISCONNECTED; color=$COLOR_DIM
    fi ;;

  *)
    wifi_device=$(echo "$services" \
      | sed -n "s/.*Hardware Port: Wi-Fi, Device: \([^\)]*\).*/\1/p")
    test -n "$wifi_device" && status=$( \
      networksetup -getairportpower "$wifi_device" | awk '{print $NF}')
    icon=$(test "$status" = On && echo "$ICON_NET_DISCONNECTED" || echo "$ICON_NET_OFF")
    color=$COLOR_DIM ;;
esac

sketchybar --animate sin 5 --set "$NAME" icon="$icon" icon.color="$color"
