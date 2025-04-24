#!/bin/bash
# Based off https://www.reddit.com/r/hyprland/comments/1b6bf39/comment/ktex67d/
# Switch to the next workspace, but if a special workspace is open, close it (and don't swtich worspace)

active=$(hyprctl -j monitors | jq --raw-output '.[] | select(.focused==true).specialWorkspace.name | split(":") | if length > 1 then .[1] else "" end')

if [[ ${#active} -gt 0 ]]; then
  hyprctl dispatch togglespecialworkspace "$active"
else
  hyprctl dispatch workspace "$1"
fi
