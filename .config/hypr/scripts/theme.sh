#!/bin/bash

reset_bar() {
    killall hybrid-bar
    hyprctl dispatch exec hybrid-bar
}

light() {
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    # cp ~/.config/hypr/themes/light.conf ~/.cache/hyprtheme.conf
    # ln -sf ~/.config/HybridBar/themes/light.css ~/.cache/hybridtheme.css
    # reset_bar
}

dark() {
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    # cp ~/.config/hypr/themes/dark.conf ~/.cache/hyprtheme.conf
    # ln -sf ~/.config/HybridBar/themes/dark.css ~/.cache/hybridtheme.css
    # reset_bar
}

toggle() {
    cur=$(gsettings get org.gnome.desktop.interface color-scheme)
    if [ "$cur" == "'prefer-dark'" ]; then
        light
    else
        dark
    fi
}

if [ "$1" = "dark" ]; then
    dark
elif [ "$1" = "light" ]; then
    light
elif [ "$1" = "toggle" ]; then
    toggle
fi
