#!/usr/bin/env bash
~/.config/hypr/scripts/toggleIdleInhibit.fish false
systemctl --user stop breakReminder.timer
