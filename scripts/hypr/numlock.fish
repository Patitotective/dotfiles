#!/bin/fish
set capsLock (hyprctl -j devices | jq '.keyboards.[] | select(.main) | .numLock')
kill -SIGRTMIN+4 $(pgrep waybar) # So that waybar updates the icon
if $capsLock == true
    echo '{"percentage": 100}'
else
    echo '{"percentage": 0}'
end
