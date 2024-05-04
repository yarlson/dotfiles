#!/bin/bash

# Get the user folder
user_folder=$(/usr/bin/getconf DARWIN_USER_DIR)

# Construct the path to the notification center database
db_path="$user_folder/com.apple.notificationcenter/db2/db"

# Count notifications excluding the specified app_id
notification_count=$(sqlite3 "$db_path" "SELECT COUNT(*) FROM record WHERE presented = 1 AND app_id NOT IN (SELECT app_id FROM app WHERE identifier='com.apple.controlcenter.notifications.focus');")

# Output the notification count
echo "Notification count: $notification_count"

