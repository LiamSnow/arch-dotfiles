#!/bin/bash

battery_path="/sys/class/power_supply/BAT*"

if [ -n "$(ls $battery_path 2>/dev/null)" ]; then
    percentage=$(cat $battery_path/capacity 2>/dev/null)
    charging_status=$(cat $battery_path/status 2>/dev/null)

    if [ "$charging_status" = "Charging" ]; then
        icon="󰂄"
    elif [ $percentage -le 33 ]; then
        icon="󱊡"
    elif [ $percentage -le 66 ]; then
        icon="󱊢"
    else
        icon="󱊣"
    fi

    echo "$icon ${percentage}%  "
fi
