#!/usr/bin/bash

pkill hypridle || hypridle
kill -SIGRTMIN+10 $(pgrep waybar)
