#!/usr/bin/env fish
set activeWorkspaceWindows (hyprctl -j activeworkspace | jq --raw-output '.windows')
if test "$activeWorkspaceWindows" -eq 0
    ~/.config/hypr/scripts/appmenu.fish
end
