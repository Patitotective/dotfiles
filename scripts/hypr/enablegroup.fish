#!/usr/bin/env fish
# used in ~/.config/hypr/core/binds.lua
# If the active window is in a group, do nothing, otherwise make it into a group
set groupedLen (hyprctl -j activewindow | jq '.grouped | length')
if test $groupedLen -eq 0
    hyprctl dispatch togglegroup
end
