#!/usr/bin/env fish
set monitors (hyprctl -j monitors all | jq length)
if test $monitors -eq 1
    ~/scripts/hypr/lock.sh
    ~/scripts/hypr/suspend.sh
end
