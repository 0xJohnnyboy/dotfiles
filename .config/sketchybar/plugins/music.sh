#!/bin/bash

CURRENT_TRACK=$(osascript -e 'tell application "Music" to if player state is playing then name of current track & " - " & artist of current track')

if [[ ${CURRENT_TRACK} == "" ]]; then
  ICON="ﱙ"
else
  ICON="ﱘ"
fi


sketchybar --set ${NAME} icon="${ICON}"
sketchybar --set ${NAME} label="${CURRENT_TRACK}"
