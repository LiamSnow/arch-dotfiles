#!/usr/bin/env bash
set -euo pipefail

sink_list=$(wpctl status -k | \
    sed -n '/Audio/,/Video/p' | \
    sed -n '/Sinks:/,/Sources:/p' | \
    sed '$d' | \
    grep -E '^\s*│\s+[*]?\s*[0-9]+' | \
    sed 's/│//g' | \
    sed 's/\[vol:.*\]//g' | \
    sed 's/^[ \t]*//' | \
    awk '{if ($1 == "*") print $2 " " $3 " *"; else print $0}')

selected=$(echo "$sink_list" | fuzzel --dmenu)

sink_id=$(echo "$selected" | cut -d'.' -f1)

wpctl set-default "$sink_id"
