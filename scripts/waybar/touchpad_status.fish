#!/usr/bin/env fish
# used in ~/.config/waybar/config.jsonc
# used in ~/.config/hypr/core/binds.lua
# no args -> get status
# on -> change status to on
# off -> change status to off

if test "$argv[1]" = off
    mkdir --parents /tmp/hypr
    touch /tmp/hypr/touchpad_off

    kill -SIGRTMIN+5 $(pgrep waybar) # update waybar
else if test "$argv[1]" = on
    rm --force /tmp/hypr/touchpad_off

    kill -SIGRTMIN+5 $(pgrep waybar) # update waybar
else if test (count $argv) -eq 0
    if test -e /tmp/hypr/touchpad_off
        echo '{"percentage": 0, "tooltip": "Touchpad disabled"}'
    end
    echo '{"percentage": 100, "tooltip": "Touchpad enabled"}'
else
    exit 1
end
