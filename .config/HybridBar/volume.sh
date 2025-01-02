#!/bin/bash

volume_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)

if [ $? -ne 0 ]; then
    echo "ERROR"
    exit 1
fi

if echo "$volume_info" | grep -q "MUTED"; then
    echo "MUTE"
else
    echo "$volume_info" | awk '{printf "%.0f%%\n", $2 * 100}'
fi
