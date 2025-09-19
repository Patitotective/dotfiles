#!/bin/fish
if pidof -qx iTunes.exe # if iTunes is running
    hyprctl dispatch sendshortcut "ctrl, left, class:itunes.exe"
else
    playerctl previous
end
