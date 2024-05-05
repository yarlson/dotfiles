#!/bin/bash

# Get the user folder
user_folder=$(/usr/bin/getconf DARWIN_USER_DIR)

# Construct the path to the notification center database
db_path="$user_folder/com.apple.notificationcenter/db2/db"

# Count notifications excluding the specified app_id
NOTTIFICATION_COUNT=$(sqlite3 "$db_path" "SELECT COUNT(*) FROM record WHERE presented = 1 AND app_id NOT IN (SELECT app_id FROM app WHERE identifier='com.apple.controlcenter.notifications.focus');")

LABEL_COLOR="0xff89dceb";

case "$NOTTIFICATION_COUNT" in
"0")
    DRAWING=off
    ;;
*)
    DRAWING=on
    ;;
esac

sketchybar --set "notification_count" icon.color=$LABEL_COLOR label.color=$LABEL_COLOR drawing=$DRAWING label="${NOTTIFICATION_COUNT}"

