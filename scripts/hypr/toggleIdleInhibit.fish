#!/usr/bin/env fish
# Set IDLE_INHIBIT_PID to 0 if it does not exist
set -q IDLE_INHIBIT_PID || set -U IDLE_INHIBIT_PID 0

# If the PID variable is set and a process by that id is running
# It means, the idle inhibitor is running so it has to kill it
if test $IDLE_INHIBIT_PID -ne 0 && ps -p $IDLE_INHIBIT_PID >/dev/null
    kill $IDLE_INHIBIT_PID
    set -U IDLE_INHIBIT_PID 0
    echo "🔓 Idle inhibition released"
else
    systemd-inhibit \
        --what="idle" \
        --who="User (from toggleIdleInhibit.fish)" \
        --mode="block" \
        sleep infinity &

    set -U IDLE_INHIBIT_PID $last_pid
    echo "🔒 Idle inhibited (PID: $IDLE_INHIBIT_PID)"
end
