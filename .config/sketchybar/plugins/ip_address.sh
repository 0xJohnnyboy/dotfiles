#!/bin/sh

source "$HOME/.config/sketchybar/vars.sh" # Loads all defined colors

COLOR_BLACK=0xe0282828
COLOR_RED=0xe0cc241d
COLOR_GREEN=0xe098971a
COLOR_YELLOW=0xe0d79921
COLOR_BLUE=0xe0458588
COLOR_MAGENTA=0xe0b16286
COLOR_CYAN=0xe0689d6a
COLOR_WHITE=0xe0a89984

IS_VPN=$(scutil --nwi | grep -m1 'utun' | awk '{ print $1 }')

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"

if [[ $IS_VPN != "" ]]; then
	COLOR=$COLOR_MAGENTA
    LABEL_COLOR=$LIGHT_COLOR
	ICON=
	LABEL="VPN"
elif [[ $SSID != "" ]]; then
	COLOR=$ACCENT_COLOR
    LABEL_COLOR=$MAIN_COLOR
	ICON=
	LABEL="${SSID} - 🔻${CURR_TX}Mbps"
else
	COLOR=$MAIN_COLOR
    LABEL_COLOR=$LIGHT_COLOR
	ICON=
	LABEL="Disconnected"
fi

sketchybar --set $NAME background.color=$COLOR \
    label.color=$LABEL_COLOR \
	icon=$ICON \
	label="$LABEL"
