#!/usr/bin/bash

pid=$(pgrep hypridle)
kill -SIGRTMIN+10 $(pgrep waybar) # So that waybar updates the icon
if [[ "$pid" == "" ]]; then echo '{"alt": "on"}'; else echo '{"alt": "off"}'; fi
