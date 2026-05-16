#!/bin/bash
# Caffeine toggle for polybar.
# ON  -> screen never blanks (DPMS + screensaver disabled)
# OFF -> normal power management restored
STATE_FILE="$HOME/.cache/polybar-caffeine"
mkdir -p "$(dirname "$STATE_FILE")"

EYE_ON=$'\uf06e'    # nf-fa-eye        — caffeine active
EYE_OFF=$'\uf070'   # nf-fa-eye_slash  — normal, screen may sleep

COLOR_ON="#98971a"  # green
COLOR_OFF="#928374" # disabled gray

is_on() { [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "on" ]; }

render() {
    if is_on; then
        printf '%%{F%s}%s %%{F-}\n' "$COLOR_ON" "$EYE_ON"
    else
        printf '%%{F%s}%s %%{F-}\n' "$COLOR_OFF" "$EYE_OFF"
    fi
}

enable_caffeine() {
    xset s off
    xset -dpms
    echo on > "$STATE_FILE"
}

disable_caffeine() {
    xset s on
    xset +dpms
    echo off > "$STATE_FILE"
}

case "$1" in
    toggle)
        if is_on; then
            disable_caffeine
        else
            enable_caffeine
        fi
        exit 0
        ;;
esac

# Default (no args): tail mode — print icon, watch state, reprint on change.
prev=""
while true; do
    curr=$(is_on && echo on || echo off)
    if [ "$curr" != "$prev" ]; then
        render
        # Re-assert xset on transition to ON so it survives X session changes.
        [ "$curr" = "on" ] && { xset s off; xset -dpms; }
        prev="$curr"
    fi
    sleep 0.3
done
