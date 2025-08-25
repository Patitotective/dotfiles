#!/usr/bin/bash
# By deleted user from https://www.reddit.com/r/hyprland/comments/1ddjvtm/comment/l8c5a93

pkill hypridle || hypridle
kill -SIGRTMIN+10 $(pgrep waybar)
