#!/bin/bash
# Spotify "now playing" for polybar.
# Default (tail) mode: print the current track and watch for changes.
# Args: playpause | next | previous  -> control Spotify (used by click/scroll).
# Only follows Spotify, so other MPRIS players (e.g. chromium) are ignored.

PLAYER=spotify

ICON_SPOTIFY=$''   # nf-fa-spotify — shown while playing
ICON_PAUSE=$''     # nf-fa-pause   — shown while paused (replaces the Spotify icon)

COLOR_SPOTIFY="#98971a"  # green — playing
COLOR_PAUSE="#928374"    # gray  — paused (dimmed)
MAXLEN=45                # max chars for "artist - title" before truncating

# Control actions (invoked from polybar click/scroll handlers).
case "$1" in
    playpause) playerctl --player="$PLAYER" play-pause 2>/dev/null; exit 0 ;;
    next)      playerctl --player="$PLAYER" next       2>/dev/null; exit 0 ;;
    previous)  playerctl --player="$PLAYER" previous   2>/dev/null; exit 0 ;;
esac

render() {
    # One call returns "status;;artist - title"; empty when Spotify isn't running.
    local out status text
    out=$(playerctl --player="$PLAYER" metadata \
            --format '{{status}};;{{artist}} - {{title}}' 2>/dev/null)

    if [ -z "$out" ]; then
        # Spotify closed / nothing loaded -> clear the module.
        printf '\n'
        return
    fi

    status=${out%%;;*}
    text=${out#*;;}

    # Truncate long "artist - title" strings with an ellipsis.
    if [ "${#text}" -gt "$MAXLEN" ]; then
        text="${text:0:$MAXLEN}…"
    fi

    case "$status" in
        Playing)
            # Playing -> only the Spotify icon (green) + track.
            printf '%%{F%s}%s%%{F-} %s\n' "$COLOR_SPOTIFY" "$ICON_SPOTIFY" "$text" ;;
        *)
            # Paused / Stopped -> hide Spotify icon, show a dimmed pause icon + track.
            printf '%%{F%s}%s %s%%{F-}\n' "$COLOR_PAUSE" "$ICON_PAUSE" "$text" ;;
    esac
}

# Default (no args): tail mode — print on change, poll once a second.
prev=""
while true; do
    curr=$(render)
    if [ "$curr" != "$prev" ]; then
        printf '%s\n' "$curr"
        prev="$curr"
    fi
    sleep 1
done
