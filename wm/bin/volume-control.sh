#!/bin/bash

# Usage: volume-control [up|down|mute]

step=5

case $1 in
    up)
        pactl set-sink-volume @DEFAULT_SINK@ +${step}%
        volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}%' | head -1)
        dunstify -a "Volume" -h string:x-dunst-stack-tag:volume \
            -h int:value:"${volume%\%}" "Volume: $volume"
        ;;
    down)
        pactl set-sink-volume @DEFAULT_SINK@ -${step}%
        volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}%' | head -1)
        dunstify -a "Volume" -h string:x-dunst-stack-tag:volume \
            -h int:value:"${volume%\%}" "Volume: $volume"
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        if pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes"; then
            dunstify -a "Volume" -h string:x-dunst-stack-tag:volume "Volume: Muted"
        else
            volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}%' | head -1)
            dunstify -a "Volume" -h string:x-dunst-stack-tag:volume \
                -h int:value:"${volume%\%}" "Volume: $volume"
        fi
        ;;
esac
