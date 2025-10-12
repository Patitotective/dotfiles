#!/usr/bin/env fish
set capsLock (hyprctl -j devices | jq '.keyboards.[] | select(.main) | .numLock')
if $capsLock == true
    echo '{"percentage": 100}'
else
    echo '{"percentage": 0}'
end
