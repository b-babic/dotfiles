#!/bin/sh

spotify=`ps -cx -o command | grep -i -e spotify$`

if [[ -z $spotify ]]; then
    echo 'Spotify is not running.'
else
    artist=`osascript -e 'tell application "Spotify" to artist of current track as string'`
    song=`osascript -e 'tell application "Spotify" to name of current track as string'`
    echo "Playing: $artist - $song"
fi
