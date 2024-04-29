#!/bin/bash

SLACK_INFO=$(lsappinfo info -only StatusLabel `lsappinfo find LSDisplayName=Slack`)
COUNT=${SLACK_INFO:25:1}

if [ $COUNT = "\"" ]; then
  DRAWING=off
else
  DRAWING=on
fi

sketchybar --set slack drawing=$DRAWING label="${COUNT}"

