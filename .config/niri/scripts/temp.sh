#!/usr/bin/env bash

DELTA="$1"

busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateTemperature n "$DELTA"

TEMP=$(busctl --user get-property rs.wl-gammarelay / rs.wl.gammarelay Temperature | awk '{print $2}')

swayosd-client --custom-icon="night-light-symbolic" --custom-message="${TEMP}K"
