#!/bin/bash

# Get list of available WiFi networks
networks=$(nmcli -f SSID,SECURITY,BARS device wifi list | tail -n +2)

# Launch rofi with the network list
selected=$(echo "$networks" | rofi -dmenu -i -p "WiFi Networks" -theme minimal)

# Extract the SSID from selection
ssid=$(echo "$selected" | awk '{print $1}')

if [ -n "$ssid" ]; then
    # Check if network is already known
    if nmcli connection show | grep -q "$ssid"; then
        nmcli connection up "$ssid"
    else
        # Connect to new network
        password=$(rofi -dmenu -p "Password" -password -theme minimal)
        nmcli device wifi connect "$ssid" password "$password"
    fi
fi
