#!/bin/bash

light() {
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
}

dark() {
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
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
