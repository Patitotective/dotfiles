#!/usr/bin/env fish
# Set MANUAL_IDLE_INHIBIT_PID to 0 if it does not exist
set -q MANUAL_IDLE_INHIBIT_PID || set -U MANUAL_IDLE_INHIBIT_PID 0
# If the PID variable is set and a process by that id is running, idle is being inhibitewd
if test $MANUAL_IDLE_INHIBIT_PID -ne 0 && ps -p $MANUAL_IDLE_INHIBIT_PID >/dev/null
    set isInhibited true
else
    set isInhibited false
end

set inhibit 0

if test "$argv[1]" = true
    set inhibit true
else if test "$argv[1]" = false
    set inhibit false
end

if test \( $inhibit = 0 -o $inhibit = false \) -a $isInhibited = true
    kill $MANUAL_IDLE_INHIBIT_PID
    set -U MANUAL_IDLE_INHIBIT_PID 0
    echo "🔓 Idle inhibition released"
else if test \( $inhibit = 0 -o $inhibit = true \) -a $isInhibited = false
    systemd-inhibit \
        --what="idle" \
        --who="User (from toggleIdleInhibit.fish)" \
        --mode="block" \
        sleep infinity &

    set -U MANUAL_IDLE_INHIBIT_PID $last_pid
    echo "🔒 Idle inhibited (PID: $MANUAL_IDLE_INHIBIT_PID)"
end
