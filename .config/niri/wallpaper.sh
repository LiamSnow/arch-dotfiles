#!/bin/bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"

WALLPAPER=$(find "$WALLPAPER_DIR" -name "*.jpg" | shuf -n 1)

if [ -n "$WALLPAPER" ]; then
    swww img "$WALLPAPER" --transition-type fade --transition-duration 2
fi
