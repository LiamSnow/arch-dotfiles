#!/bin/bash

clamp() {
    local min=$1
    local max=$2
    local value=$3
    echo $(( value < min ? min : value > max ? max : value ))
}

current_brightness=$(cat /home/liams/.config/hypr/scripts/bsync.txt)

if [ "$1" = "up" ]; then
    new_brightness=$((current_brightness + 10))
elif [ "$1" = "down" ]; then
    new_brightness=$((current_brightness - 10))
else
    echo "invalid arg"
    exit 1
fi

new_brightness=$(clamp 0 100 $new_brightness)
light_brightness=$(clamp 1 100 $new_brightness)

home crib bri $light_brightness &
ddcutil setvcp 10 $new_brightness &
echo $new_brightness > /home/liams/.config/hypr/scripts/bsync.txt &

wait
