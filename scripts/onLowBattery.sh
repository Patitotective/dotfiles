#!/bin/sh
notify-send -u critical -a "Power Management (user)" "Low Battery" "Plug your computer to avoid losing any work."
mpv --loop=1 /usr/share/sounds/freedesktop/stereo/suspend-error.oga
