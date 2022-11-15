#!/usr/bin/env sh
source $HOME/.config/sketchybar/vars.sh

sketchybar --set $NAME icon="􀉉"\
                       icon.color=$LIGHT_COLOR\
                       label="$(date '+%a %d %b 􀐬 %H:%M')"\
                       label.color=$LIGHT_COLOR\
                       background.padding_right=0\
                       background.padding_left=16\
