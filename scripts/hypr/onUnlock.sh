#!/bin/bash
systemctl --user start breakReminder.timer

kill -SIGRTMIN+3 $(pgrep waybar) # update capslock state
kill -SIGRTMIN+4 $(pgrep waybar) # update numlock state
