#!/bin/bash

ACTION="$1"

# CONFIRM=$(echo -e "No\nYes" | wofi --dmenu --prompt "Are you sure?")

# [ "$CONFIRM" != "Yes" ] && exit 0

case "$ACTION" in
    shutdown) systemctl poweroff ;;
    reboot) systemctl reboot ;;
esac
