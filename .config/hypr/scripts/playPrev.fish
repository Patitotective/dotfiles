#!/usr/bin/env fish
playerctl previous
# TODO: sometimes when you go to the next song and it takes longer than a second to load, then in hyprlock it looks like its paused cause the signal reached when it wasn't playing yet
sleep 1 && pkill -USR2 hyprlock & # update player state
# if pidof -qx iTunes.exe # if iTunes is running
#     hyprctl dispatch sendshortcut ", esc, class:itunes.exe" # to close any menus or so
#     hyprctl dispatch sendshortcut "ctrl, left, class:itunes.exe"
# else
#     playerctl previous
# end
