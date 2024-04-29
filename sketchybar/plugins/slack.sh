#!/bin/bash

SLACK_INFO=$(lsappinfo info -only StatusLabel `lsappinfo find LSDisplayName=Slack`)
COUNT=${SLACK_INFO:25:1}

if [ $COUNT = "\"" ]; then
  DRAWING=off
else
  DRAWING=on
fi

case "$COUNT" in
"\"")
    LABEL_COLOR=0xffffffff;
    ;;
"•")
   LABEL_COLOR=0xffffffff;
    ;;
*)
    LABEL_COLOR=0xffed8796;
    ;;
esac

sketchybar --set slack icon.color=$LABEL_COLOR label.color=$LABEL_COLOR drawing=$DRAWING label="${COUNT}"

