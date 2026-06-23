#!/usr/bin/env fish
# used in ~/.config/hypr/core/binds.lua
set monitors (hyprctl -j monitors all | jq length)
if test $monitors -eq 1
    ~/scripts/hypr/lock.sh
    ~/scripts/hypr/suspend.sh
end
