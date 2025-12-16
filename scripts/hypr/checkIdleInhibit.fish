#!/usr/bin/env fish
if set -q IDLE_INHIBIT_PID; and test $IDLE_INHIBIT_PID -ne 0 && ps -p $IDLE_INHIBIT_PID >/dev/null
    echo '{"alt": "on"}'
else
    echo '{"alt": "off"}'
end
kill -SIGRTMIN+1 $(pgrep waybar) # So that waybar updates the icon
