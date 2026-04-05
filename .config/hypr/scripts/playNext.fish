#!/usr/bin/env fish
playerctl next
sleep 1 && pkill -USR2 hyprlock & # update player state
# if pidof -qx iTunes.exe # if iTunes is running
#     hyprctl dispatch sendshortcut ", esc, class:itunes.exe" # to close any menus or so
#     hyprctl dispatch sendshortcut "ctrl, right, class:itunes.exe"
# else
#     playerctl next
# end
