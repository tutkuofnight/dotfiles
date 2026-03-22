#!/bin/bash
mkdir -p ~/Pictures/Screenshots
grim -g "$(slurp -c '#ff0000ff')" -t ppm - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
