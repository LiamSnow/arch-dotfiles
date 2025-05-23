#!/bin/bash

if [ ! "$(ykman info)" ]; then
    notify-send "walker-ykman" "YubiKey not detected." -a "walker-ykman"
    exit 1
fi

accounts=$(ykman oath accounts list)
echo "${accounts/, TOTP/\n}"

account=$(echo "${accounts/, TOTP/\n}" | walker -d)
[ $? -eq 1 ] && exit

code=$(ykman oath accounts code "$account")
IFS=', ' read -r -a code <<< "$code"

echo -n "${code[-1]}" | wtype -
