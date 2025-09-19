#!/bin/fish
if pidof -qx iTunes.exe # if iTunes is running
    hyprctl dispatch sendshortcut "ctrl, right, class:itunes.exe"
else
    playerctl next
end
