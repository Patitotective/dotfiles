#!/bin/fish
if pidof -qx iTunes.exe # if iTunes is running
    hyprctl dispatch sendshortcut ", space, class:itunes.exe"
else
    playerctl play-pause
end
