#!/usr/bin/env bash

SLACK_ICON="󰂱"
BATTERY_ICONS=("󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹")
CHARGING_ICON="󰉁"

COLOR_MUTED="#878580"
COLOR_RED="#d14d41"
COLOR_ORANGE="#da702c"
COLOR_YELLOW="#d0a215"
COLOR_GREEN="#879a39"
COLOR_CYAN="#3aa99f"

slack_status() {
	command -v lsappinfo >/dev/null 2>&1 || return 0

	local app_id slack_info count
	app_id=$(lsappinfo find "LSDisplayName=Slack" 2>/dev/null | head -n 1)
	case "$app_id" in
	ASN:*) ;;
	*) return 0 ;;
	esac

	slack_info=$(lsappinfo info -only StatusLabel "$app_id" 2>/dev/null)
	count=$(printf '%s\n' "$slack_info" | awk -F'"label"="' '{print $2}' | awk -F'"' '{print $1}')
	[[ $count =~ ^[0-9]+[+]?$ ]] || return 0

	printf '#[fg=%s]%s %s' "$COLOR_MUTED" "$SLACK_ICON" "$count"
}

battery_status() {
	command -v pmset >/dev/null 2>&1 || return 0

	local battery_line percentage icon_index icon charging_suffix color
	battery_line=$(pmset -g batt 2>/dev/null | awk '/InternalBattery/ {print}')
	[[ $battery_line =~ ([0-9]+)% ]] || return 0
	percentage=${BASH_REMATCH[1]}
	((percentage <= 100)) || return 0
	icon_index=$((percentage / 10))
	icon=${BATTERY_ICONS[$icon_index]}
	charging_suffix=""

	if [[ $battery_line == *"; charging;"* ]]; then
		charging_suffix=" $CHARGING_ICON"
		color=$COLOR_CYAN
	else
		if ((percentage <= 20)); then
			color=$COLOR_RED
		elif ((percentage <= 40)); then
			color=$COLOR_ORANGE
		elif ((percentage <= 60)); then
			color=$COLOR_YELLOW
		else
			color=$COLOR_GREEN
		fi
	fi

	printf '#[fg=%s]%s%s %s%%' "$color" "$icon" "$charging_suffix" "$percentage"
}

clock_status() {
	command -v date >/dev/null 2>&1 || return 0
	printf '#[fg=%s]%s' "$COLOR_MUTED" "$(date '+%F %H:%M')"
}

main() {
	local segment status_function
	local -a segments=()

	for status_function in slack_status battery_status clock_status; do
		segment=$($status_function)
		[[ -n $segment ]] && segments+=("$segment")
	done

	local IFS=' '
	printf '%s' "${segments[*]}"
}

main
