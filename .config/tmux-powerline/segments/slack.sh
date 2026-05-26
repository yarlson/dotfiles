# shellcheck shell=bash

TMUX_POWERLINE_SEG_SLACK_APP_NAME="${TMUX_POWERLINE_SEG_SLACK_APP_NAME:-Slack}"
TMUX_POWERLINE_SEG_SLACK_ICON="${TMUX_POWERLINE_SEG_SLACK_ICON:-󰒱}"

run_segment() {
	command -v lsappinfo >/dev/null 2>&1 || return 0

	local app_id slack_info count
	app_id=$(lsappinfo find "LSDisplayName=$TMUX_POWERLINE_SEG_SLACK_APP_NAME" 2>/dev/null | head -n 1)
	case "$app_id" in
	ASN:*) ;;
	*) return 0 ;;
	esac

	slack_info=$(lsappinfo info -only StatusLabel "$app_id" 2>/dev/null)
	count=$(printf '%s\n' "$slack_info" | awk -F'"label"="' '{print $2}' | awk -F'"' '{print $1}')

	case "$count" in
	"" | "\"" | "•")
		return 0
		;;
	*)
		printf '%s %s' "$TMUX_POWERLINE_SEG_SLACK_ICON" "$count"
		;;
	esac
}
