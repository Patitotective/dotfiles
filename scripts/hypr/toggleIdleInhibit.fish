#!/usr/bin/env fish
# Set MANUAL_IDLE_INHIBIT_PID to 0 if it does not exist
set -q MANUAL_IDLE_INHIBIT_PID || set -U MANUAL_IDLE_INHIBIT_PID 0

# If the PID variable is set and a process by that id is running
# It means, the idle inhibitor is running so it has to kill it
if test $MANUAL_IDLE_INHIBIT_PID -ne 0 && ps -p $MANUAL_IDLE_INHIBIT_PID >/dev/null
    kill $MANUAL_IDLE_INHIBIT_PID
    set -U MANUAL_IDLE_INHIBIT_PID 0
    echo "🔓 Idle inhibition released"
else
    systemd-inhibit \
        --what="idle" \
        --who="User (from toggleIdleInhibit.fish)" \
        --mode="block" \
        sleep infinity &

    set -U MANUAL_IDLE_INHIBIT_PID $last_pid
    echo "🔒 Idle inhibited (PID: $MANUAL_IDLE_INHIBIT_PID)"
end
