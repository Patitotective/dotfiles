#!/usr/bin/env bash
# used in ~/.config/hypr/hypridle.conf
# used in ~/.config/hypr/core/autostart.lua
systemctl --user start breakReminder.timer

kill -SIGRTMIN+3 $(pgrep waybar) # update capslock state
kill -SIGRTMIN+4 $(pgrep waybar) # update numlock state
