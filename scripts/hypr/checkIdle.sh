#!/usr/bin/env bash
# By deleted user from https://www.reddit.com/r/hyprland/comments/1ddjvtm/comment/l8c5a93

pid=$(pgrep hypridle)
kill -SIGRTMIN+1 $(pgrep waybar) # So that waybar updates the icon
if [[ "$pid" == "" ]]; then echo '{"alt": "on"}'; else echo '{"alt": "off"}'; fi
