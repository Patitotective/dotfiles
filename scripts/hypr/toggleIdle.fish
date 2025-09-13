#!/bin/fish
# By deleted user from https://www.reddit.com/r/hyprland/comments/1ddjvtm/comment/l8c5a93
if pidof -qx hypridle # if hypridle is running
    if test "$argv[1]" = false -o (count $argv) -eq 0
        pkill hypridle
        kill -SIGRTMIN+1 $(pgrep waybar)
    end
else # if it's not
    if test "$argv[1]" = true -o (count $argv) -eq 0
        hypridle &
        kill -SIGRTMIN+1 $(pgrep waybar)
    end
end
