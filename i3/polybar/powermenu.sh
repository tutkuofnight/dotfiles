#!/bin/bash

power=" Power Off"
reboot=" Reboot"
suspend=" Suspend"
logout=" Logout"
lock=" Lock"

chosen=$(echo -e "$power
$reboot
$suspend
$logout
$lock" | rofi -dmenu -p "Power Menu")

case $chosen in
    "$power")   systemctl poweroff ;;
    "$reboot")  systemctl reboot ;;
    "$suspend") systemctl suspend ;;
    "$logout")  i3-msg exit ;;
    "$lock")    i3lock ;;
esac