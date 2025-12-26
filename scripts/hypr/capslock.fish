#!/usr/bin/env fish
set capsLock (hyprctl -j devices | jq '.keyboards.[] | select(.main) | .capsLock')
if $capsLock == true
    echo '{"percentage": 100, "tooltip": "Capslock enabled"}'
else
    echo '{"percentage": 0, "tooltip": "Capslock disabled"}'
end
