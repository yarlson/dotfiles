#!/bin/sh

sketchybar --set "$NAME" label="$(curl 'wttr.in?format=1' | tr -s ' ' | sed 's/^\s*//;s/\s*$//')"
