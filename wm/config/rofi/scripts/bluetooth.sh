#!/bin/bash

# Get list of available Bluetooth devices
devices=$(bluetoothctl devices | cut -d ' ' -f 3-)

# Add options for power on/off
options="Power On\nPower Off\n---\n$devices"

# Launch rofi with the device list
selected=$(echo -e "$options" | rofi -dmenu -i -p "Bluetooth" -theme minimal)

case "$selected" in
    "Power On")
        bluetoothctl power on
        ;;
    "Power Off")
        bluetoothctl power off
        ;;
    *)
        if [ -n "$selected" ]; then
            device_mac=$(bluetoothctl devices | grep "$selected" | cut -d ' ' -f 2)
            if [ -n "$device_mac" ]; then
                bluetoothctl connect "$device_mac"
            fi
        fi
        ;;
esac
