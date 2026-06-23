#!/usr/bin/env bash
# used in ~/.config/wlogout/layout
~/scripts/hypr/events/onExit.sh
loginctl terminate-user "$USER"
