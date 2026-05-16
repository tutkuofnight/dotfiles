#!/bin/bash
for iface in enp3s0 wlan0; do
    if ip -4 addr show "$iface" 2>/dev/null | grep -q "inet "; then
        exit 0
    fi
done
printf ''
