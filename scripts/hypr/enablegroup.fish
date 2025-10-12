#!/usr/bin/env fish
# If the active window is in a group, do nothing, otherwise make it into a group
set groupedLen (hyprctl -j activewindow | jq '.grouped | length')
if test $groupedLen -eq 0
    hyprctl dispatch togglegroup
end
