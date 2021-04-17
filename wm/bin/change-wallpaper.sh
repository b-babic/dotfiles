#!/bin/bash

WALLPAPERS_DIR="$HOME/Pictures/Wallpapers"
WALLPAPER=$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)
feh --bg-fill "$WALLPAPER"
