#\!/usr/bin/env bash

source "$CONFIG_DIR/icons.sh"

status=$(curl -sf --max-time 10 'wttr.in/Riga?format=%C+|+%t&m')

if [[ $? -ne 0 || -z "$status" ]]; then
  sketchybar --set "$NAME" label="--"
  exit 0
fi

condition=$(echo "$status" | awk -F '|' '{ print $1 }' | tr '[:upper:]' '[:lower:]')
condition="${condition// /}"
temp=$(echo "$status" | awk -F '|' '{ print $2 }')
temp="${temp//+/}"
temp="${temp// /}"

case "${condition}" in
  "sunny"|"clear")                icon="$ICON_WEATHER_SUNNY" ;;
  "partlycloudy")                 icon="$ICON_WEATHER_PARTLY_CLOUDY" ;;
  "cloudy")                       icon="$ICON_WEATHER_CLOUDY" ;;
  "overcast")                     icon="$ICON_WEATHER_OVERCAST" ;;
  "mist"|"fog"|"freezingfog")     icon="$ICON_WEATHER_FOG" ;;
  "patchylightdrizzle"|"lightdrizzle"|"drizzle"|"freezingdrizzle"|"heavyfreezingdrizzle") icon="$ICON_WEATHER_DRIZZLE" ;;
  "patchylightrain"|"lightrain"|"patchyrainpossible") icon="$ICON_WEATHER_DRIZZLE" ;;
  "moderaterain"|"moderaterainattimes"|"rain")        icon="$ICON_WEATHER_RAIN" ;;
  "heavyrain"|"heavyrainattimes"|"torrentialrainshower") icon="$ICON_WEATHER_HEAVY_RAIN" ;;
  "lightfreezingrain"|"moderateorheavyfreezingrain")  icon="$ICON_WEATHER_SLEET" ;;
  "lightsleet"|"moderateorheavysleet"|"lightsleetshowers"|"moderateorheavysleetshowers") icon="$ICON_WEATHER_SLEET" ;;
  "patchylightsnow"|"lightsnow"|"patchysnowpossible") icon="$ICON_WEATHER_SNOW" ;;
  "moderatesnow"|"patchymoderatesnow"|"snow")         icon="$ICON_WEATHER_SNOW" ;;
  "heavysnow"|"patchyheavysnow"|"blizzard"|"blowingsnow") icon="$ICON_WEATHER_HEAVY_SNOW" ;;
  "icepellets"|"lightshowersoficepellets"|"moderateorheavyshowersoficepellets") icon="$ICON_WEATHER_HAIL" ;;
  "thunderyoutbreakspossible"|"patchylightrainwiththunder"|"moderateorheavyrainwiththunder") icon="$ICON_WEATHER_THUNDER" ;;
  "patchylightsnowwiththunder"|"moderateorheavysnowwiththunder") icon="$ICON_WEATHER_THUNDER" ;;
  *)                              icon="$ICON_WEATHER_CLOUDY" ;;
esac

sketchybar --set "$NAME" icon="$icon" label="$temp"
