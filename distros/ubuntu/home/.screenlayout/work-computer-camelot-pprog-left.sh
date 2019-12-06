#!/bin/sh
xrandr --auto
xrandr --output HDMI-2 --off --output HDMI-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output eDP-1 --primary --mode 1920x1080 --pos 2200x1440 --rotate normal --output DP-2 --mode 2560x1440 --pos 1920x0 --rotate normal
