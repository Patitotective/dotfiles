#!/usr/bin/env fish
# used in ~/.config/hypr/core/binds.lua
playerctl play-pause
pkill -USR2 hyprlock # update player state
# if pidof -qx iTunes.exe # if iTunes is running
#     hyprctl dispatch sendshortcut ", esc, class:itunes.exe" # to close any menus or so
#     hyprctl dispatch sendshortcut ", space, class:itunes.exe"
# else
#     playerctl play-pause
#     pkill -USR2 hyprlock # update player state
# end
