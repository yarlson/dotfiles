#!/usr/bin/env bash

status=$(curl -sf --max-time 10 'wttr.in/Riga?format=%C+|+%t&m')

if [[ $? -ne 0 || -z "$status" ]]; then
  sketchybar --set "$NAME" label="--"
  exit 0
fi

condition=$(echo "$status" | awk -F '|' '{print $1}' | tr '[:upper:]' '[:lower:]')
condition="${condition// /}"
temp=$(echo "$status" | awk -F '|' '{print $2}')
temp="${temp//+/}"
temp="${temp// /}"

case "${condition}" in
  "sunny"|"clear")          icon="" ;;
  "partlycloudy")           icon="" ;;
  "cloudy"|"overcast")      icon="" ;;
  "mist"|"fog")             icon="" ;;
  "lightrain"|"drizzle"|"patchylightrain"|"lightdrizzle") icon="" ;;
  "rain"|"moderaterain"|"heavyrain")                      icon="" ;;
  "snow"|"lightsnow"|"heavysnow"|"blizzard")              icon="" ;;
  "thunderstorm"|"thunder")                               icon="" ;;
  *)                        icon="$condition" ;;
esac

sketchybar --set "$NAME" icon="$icon" label="$temp"
