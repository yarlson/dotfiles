#!/bin/sh

sketchybar --set "$NAME" label="$(curl 'v2d.wttr.in?format=1' | tr -s ' ' | sed 's/^\s*//;s/\s*$//')"