#!/bin/bash

SLACK_INFO=$(lsappinfo info -only StatusLabel `lsappinfo find LSDisplayName=Slack`)
COUNT=${SLACK_INFO:25:1}

case "$COUNT" in
"")
    DRAWING=off
    LABEL_COLOR=0xffffffff;
    ;;
"\"")
    DRAWING=off
    LABEL_COLOR=0xffffffff;
    ;;
"•")
    DRAWING=on
    LABEL_COLOR=0xffffffff;
    ;;
*)
    DRAWING=on
    LABEL_COLOR=0xffa6da95;
    ;;
esac

sketchybar --set slack icon.color=$LABEL_COLOR label.color=$LABEL_COLOR drawing=$DRAWING label="${COUNT}"

