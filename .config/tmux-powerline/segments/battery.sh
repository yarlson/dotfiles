# shellcheck shell=bash

BATTERY_FULL="󱊣"
BATTERY_MED="󱊢"
BATTERY_EMPTY="󱊡"
BATTERY_CHARGE="󰂄"

COLOR_GREEN="#66800b"
COLOR_YELLOW="#ad8301"
COLOR_RED="#af3029"

run_segment() {
	command -v pmset >/dev/null 2>&1 || return 0

	local battery_line percentage icon color
	battery_line=$(pmset -g batt | awk '/InternalBattery/ {print}')
	[ -n "$battery_line" ] || return 0

	percentage=$(printf '%s\n' "$battery_line" | grep -o '[0-9][0-9]*%' | tr -d '%')
	[ -n "$percentage" ] || return 0

	case "$battery_line" in
	*charging* | *charged* | *AC\ Power*)
		icon="$BATTERY_CHARGE"
		;;
	*)
		icon=$(__battery_icon "$percentage")
		;;
	esac

	color=$(__battery_color "$percentage")
	printf '#[fg=%s]%s %s%%' "$color" "$icon" "$percentage"
}

__battery_icon() {
	local percentage=$1

	if [ "$percentage" -lt 20 ]; then
		printf '%s' "$BATTERY_EMPTY"
	elif [ "$percentage" -lt 50 ]; then
		printf '%s' "$BATTERY_MED"
	else
		printf '%s' "$BATTERY_FULL"
	fi
}

__battery_color() {
	local percentage=$1

	if [ "$percentage" -lt 20 ]; then
		printf '%s' "$COLOR_RED"
	elif [ "$percentage" -lt 50 ]; then
		printf '%s' "$COLOR_YELLOW"
	else
		printf '%s' "$COLOR_GREEN"
	fi
}
