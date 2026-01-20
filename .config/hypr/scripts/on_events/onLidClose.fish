#!/usr/bin/env fish
set monitors (hyprctl -j monitors all | jq length)
if test $monitors -eq 1
    ~/.config/hypr/scripts/wlogout/lock.sh
    ~/.config/hypr/scripts/wlogout/suspend.sh
end
