#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME label="$2 $1" background.drawing=on
else
    sketchybar --set $NAME label="$2" background.drawing=off
fi
