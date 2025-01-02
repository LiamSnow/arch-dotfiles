#!/bin/bash

case $(echo -e "$(hyprctl -j monitors)" | jq -r '.[0] | "\(.activeWorkspace.id)"') in
    1) echo "w" ;;
    2) echo "e" ;;
    3) echo "i" ;;
    4) echo "o" ;;
    5) echo " " ;;
    *) echo "ERR" ;;
esac
