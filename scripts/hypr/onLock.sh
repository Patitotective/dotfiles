#!/usr/bin/env bash
~/scripts/hypr/toggleIdleInhibit.fish false
systemctl --user stop breakReminder.timer
