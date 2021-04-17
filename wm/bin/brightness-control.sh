#!/bin/bash

# Usage: brightness-control [up|down]

step=5

case $1 in
    up)
        brightnessctl set ${step}%+
        brightness=$(brightnessctl get)
        max_brightness=$(brightnessctl max)
        percent=$((brightness * 100 / max_brightness))
        dunstify -a "Brightness" -h string:x-dunst-stack-tag:brightness \
            -h int:value:"$percent" "Brightness: ${percent}%"
        ;;
    down)
        brightnessctl set ${step}%-
        brightness=$(brightnessctl get)
        max_brightness=$(brightnessctl max)
        percent=$((brightness * 100 / max_brightness))
        dunstify -a "Brightness" -h string:x-dunst-stack-tag:brightness \
            -h int:value:"$percent" "Brightness: ${percent}%"
        ;;
esac
