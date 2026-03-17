#!/bin/bash
# ─────────────────────────────────────────────────────────────────
# toggle-play.sh — Akıllı Play/Pause Toggle
# play-pause komutu çalışmayan player'lar için
# Yerleştir: ~/.config/waybar/scripts/toggle-play.sh
# ─────────────────────────────────────────────────────────────────

PREFERRED=("spotify" "firefox" "chromium" "brave" "vlc" "mpv")

get_player() {
    local all_players
    all_players=$(playerctl -l 2>/dev/null)
    [ -z "$all_players" ] && return

    for preferred in "${PREFERRED[@]}"; do
        while IFS= read -r player; do
            if [[ "$player" == *"$preferred"* ]]; then
                echo "$player"
                return
            fi
        done <<< "$all_players"
    done

    echo "$all_players" | head -1
}

PLAYER=$(get_player)

if [ -z "$PLAYER" ]; then
    notify-send "Media" "Hiç player bulunamadı" -t 2000 2>/dev/null
    exit 0
fi

# Status'e göre toggle
STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null)

case "$STATUS" in
    Playing)
        playerctl -p "$PLAYER" pause
        ;;
    Paused)
        playerctl -p "$PLAYER" play
        ;;
    *)
        # Bilinmeyen durumda önce play dene
        playerctl -p "$PLAYER" play 2>/dev/null || \
        playerctl -p "$PLAYER" pause 2>/dev/null
        ;;
esac
