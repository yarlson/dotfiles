#!/usr/bin/env bash

sketchybar --add item merge_queue right \
           --set merge_queue update_freq=60 script="$PLUGIN_DIR/merge_queue.sh"
