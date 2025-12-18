#!/usr/bin/env fish
if set -q MANUAL_IDLE_INHIBIT_PID; and test $MANUAL_IDLE_INHIBIT_PID -ne 0 && ps -p $MANUAL_IDLE_INHIBIT_PID >/dev/null
    echo '{"alt": "on"}'
else
    echo '{"alt": "off"}'
end
kill -SIGRTMIN+1 $(pgrep waybar) # So that waybar updates the icon
