#!/bin/bash
# Unified network status for polybar — shows exactly ONE icon, by priority:
#   ethernet has an IP   -> ethernet icon (blue)
#   else wifi has an IP   -> wifi icon (blue)
#   else                  -> "no connection" icon (gray)
# Click opens nmtui. Default (tail) mode: poll, reprint only on change.
# Replaces the old eth + wlan + noconn modules so they can't overlap.

ETH_IF=enp3s0
WLAN_IF=wlan0

ICON_ETH=$''    # nf-fa-sitemap       — wired
ICON_WIFI=$''   # nf-fa-wifi          — wireless
ICON_NONE=$''   # nf-fa-chain_broken  — no connection

COLOR_CONN="#458588"  # blue (colors.blue)    — connected
COLOR_NONE="#928374"  # gray (colors.disabled) — no connection

CLICK="kitty -e nmtui"

has_ip() { ip -4 addr show "$1" 2>/dev/null | grep -q "inet "; }

emit() { # $1=color $2=icon  -> clickable single icon (trailing space for right padding)
    printf '%%{A1:%s:}%%{F%s}%s %%{F-}%%{A}\n' "$CLICK" "$1" "$2"
}

render() {
    if has_ip "$ETH_IF"; then
        emit "$COLOR_CONN" "$ICON_ETH"
    elif has_ip "$WLAN_IF"; then
        emit "$COLOR_CONN" "$ICON_WIFI"
    else
        emit "$COLOR_NONE" "$ICON_NONE"
    fi
}

prev=""
while true; do
    curr=$(render)
    if [ "$curr" != "$prev" ]; then
        printf '%s\n' "$curr"
        prev="$curr"
    fi
    sleep 3
done
