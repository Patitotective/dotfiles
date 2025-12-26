#!/usr/bin/env fish
if set -q MANUAL_IDLE_INHIBIT_PID; and test $MANUAL_IDLE_INHIBIT_PID -ne 0 && ps -p $MANUAL_IDLE_INHIBIT_PID >/dev/null
    echo '{"alt": "on", "tooltip": "Idle inhibited"}'
else
    echo '{"alt": "off", "tooltip": "Idle uninhibited"}'
end
kill -SIGRTMIN+1 $(pgrep waybar) # So that waybar updates the icon
