#!/bin/fish
if pidof -qx iTunes.exe # if iTunes is running
    hyprctl dispatch sendshortcut ", esc, class:itunes.exe" # to close any menus or so
    hyprctl dispatch sendshortcut ", space, class:itunes.exe"
else
    playerctl play-pause
end
