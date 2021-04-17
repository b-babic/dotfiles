#!/bin/bash

options="Logout\nSuspend\nReboot\nShutdown"

selected=$(echo -e $options | rofi -dmenu -i -p "Power Menu" -theme minimal)

case $selected in
    Logout)
        i3-msg exit
        ;;
    Suspend)
        systemctl suspend
        ;;
    Reboot)
        systemctl reboot
        ;;
    Shutdown)
        systemctl poweroff
        ;;
esac
