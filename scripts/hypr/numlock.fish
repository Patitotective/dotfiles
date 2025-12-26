#!/usr/bin/env fish
set capsLock (hyprctl -j devices | jq '.keyboards.[] | select(.main) | .numLock')
if $capsLock == true
    echo '{"percentage": 100, "tooltip": "Numlock enabled"}'
else
    echo '{"percentage": 0, "tooltip": "Numlock disabled"}'
end
