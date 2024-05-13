#!/bin/bash

SLACK_INFO=$(lsappinfo info -only StatusLabel `lsappinfo find LSDisplayName=Slack`)
COUNT=$(echo "$SLACK_INFO" | awk -F'"label"="' '{print $2}' | awk -F'"' '{print $1}')


LABEL_COLOR=0xffffffff;

case "$COUNT" in
"")
    DRAWING=off
    ;;
"\"")
    DRAWING=off
    ;;
"•")
    DRAWING=on
    ;;
*)
    DRAWING=on
    LABEL_COLOR=0ffa6e3a1;
    ;;
esac

sketchybar --set slack icon.color=$LABEL_COLOR label.color=$LABEL_COLOR drawing=$DRAWING label="${COUNT}"

