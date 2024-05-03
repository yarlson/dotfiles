#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Close all apps
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

osascript -e 'tell application "System Events" to get the name of every process where background only is false and visible is true' | tr ',' '\n' | while read app; do
    app=$(echo $app | xargs)

    if [[ "$app" != "Finder" ]] && [[ "$app" != "SystemUIServer" ]] ; then
        echo "Closing app: $app"
        osascript -e "tell application \"$app\" to quit"
    else
        echo "Skipping essential system application: $app"
    fi
done
