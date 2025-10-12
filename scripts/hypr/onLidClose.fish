#!/usr/bin/env fish
if not pidof -qx hypridle # if hypridle is not running
    ~/scripts/hypr/toggleIdle.fish true
end

set monitors (hyprctl -j monitors all | jq length)
if test $monitors -eq 1
    ~/scripts/hypr/lock.sh
    ~/scripts/hypr/suspend.sh
end
