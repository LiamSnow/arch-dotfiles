#!/bin/bash

if [ ! "$(ykman info)" ]; then
    if hash notify-send 2>/dev/null; then
        notify-send "bemenu-ykman" "YubiKey not detected." -a "bemenu-ykman"
    fi
    exit 1
fi

accounts=$(ykman oath accounts list)
prompt="YubiKey OATH"

account=$(echo "${accounts/, TOTP/\n}" | bemenu -p "$prompt" "$@")
[ $? -eq 1 ] && exit

code=$(ykman oath accounts code "$account")
IFS=', ' read -r -a code <<< "$code"

echo -n "${code[-1]}" | wtype -
