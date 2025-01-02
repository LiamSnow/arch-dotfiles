#!/bin/bash

clamp() {
    local min=$1
    local max=$2
    local value=$3
    echo $(( value < min ? min : value > max ? max : value ))
}

current_temp=$(cat /home/liams/.config/hypr/scripts/temp.txt)

if [ "$1" = "up" ]; then
    new_temp=$((current_temp - 100))
elif [ "$1" = "down" ]; then
    new_temp=$((current_temp + 100))
else
    echo "invali arg"
    exit 1
fi

new_temp=$(clamp 1000 5100 $new_temp)
killall gammastep > /dev/null

if [ "$new_temp" -le 5000 ]; then
    gammastep -P -O "$new_temp" &
fi

echo $new_temp > /home/liams/.config/hypr/scripts/temp.txt &

wait
