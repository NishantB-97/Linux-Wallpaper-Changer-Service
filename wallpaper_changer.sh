#!/bin/bash

WALLPAPER_DIR="/home/nishantbidarkar/Pictures/Wallpapers"
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u)/bus"

gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER"
gsettings set org.gnome.desktop.background picture-options 'zoom'
