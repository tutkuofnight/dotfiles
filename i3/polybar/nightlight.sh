#!/bin/bash
# Night light toggle for polybar (X11 / redshift one-shot).
# ON  -> warm color temperature (easier on the eyes)
# OFF -> normal color temperature restored
STATE_FILE="$HOME/.cache/polybar-nightlight"
mkdir -p "$(dirname "$STATE_FILE")"

TEMP=4500          # warm temperature in Kelvin (lower = warmer)

MOON_ON=$'\U000f0594'   # nf-md-weather_night  — night light active (centered glyph)
MOON_OFF=$'\U000f0599'  # nf-md-weather_sunny  — normal (centered glyph)

COLOR_ON="#d65d0e"  # orange
COLOR_OFF="#928374" # disabled gray

is_on() { [ -f "$STATE_FILE" ] && [ "$(cat "$STATE_FILE")" = "on" ]; }

render() {
    if is_on; then
        printf '%%{F%s}%s%%{F-}%%{O2}\n' "$COLOR_ON" "$MOON_ON"
    else
        printf '%%{F%s}%s%%{F-}%%{O2}\n' "$COLOR_OFF" "$MOON_OFF"
    fi
}

enable_nightlight() {
    redshift -P -O "$TEMP" >/dev/null 2>&1
    echo on > "$STATE_FILE"
}

disable_nightlight() {
    redshift -x >/dev/null 2>&1
    echo off > "$STATE_FILE"
}

case "$1" in
    toggle)
        if is_on; then
            disable_nightlight
        else
            enable_nightlight
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
        # Re-assert temperature on transition to ON so it survives reloads.
        [ "$curr" = "on" ] && redshift -P -O "$TEMP" >/dev/null 2>&1
        prev="$curr"
    fi
    sleep 0.3
done
