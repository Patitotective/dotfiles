#!/usr/bin/env bash
# used in ~/.config/hypr/hypridle.conf
~/scripts/hypr/toggleIdleInhibit.fish false
systemctl --user stop breakReminder.timer
