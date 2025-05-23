#!/bin/bash

case $(echo -e "$(hyprctl -j monitors)" | jq -r '.[0] | "\(.activeWorkspace.id)"') in
    1) echo "w" ;;
    2) echo "e" ;;
    3) echo "a" ;;
    4) echo "s" ;;
    5) echo "d" ;;
    6) echo " " ;;
    *) echo "ERR" ;;
esac
