#!/usr/bin/env fish
set layouts dwindle master scrolling monocle
set cur_layout (hyprctl -j getoption general:layout | jq --raw-output '.str')
if test "$argv[1]" = prev
    set prev
end

if contains $cur_layout monocle
    # TODO: here it should actually cycle through floating windows, but it does not so i just disabled this layout 🤷
    if set -q prev
        hyprctl dispatch layoutmsg cyclenext prev
    else
        hyprctl dispatch layoutmsg cyclenext
    end
else
    if set -q prev
        hyprctl dispatch cyclenext prev
    else
        hyprctl dispatch cyclenext
    end
end
