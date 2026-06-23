#!/usr/bin/env fish
# used in ~/.config/hypr/core/binds.lua
set activeWorkspaceWindows (hyprctl -j activeworkspace | jq --raw-output '.windows')
if test "$activeWorkspaceWindows" -eq 0
    ~/scripts/hypr/appmenu.fish
end
