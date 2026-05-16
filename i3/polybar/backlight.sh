#!/bin/bash
prev=""
while true; do
    curr=$(brightnessctl -m 2>/dev/null | awk -F',' '{gsub("%","",$4); print $4}')
    if [ "$curr" != "$prev" ]; then
        printf '%s%%\n' "$curr"
        prev="$curr"
    fi
    sleep 0.1
done
