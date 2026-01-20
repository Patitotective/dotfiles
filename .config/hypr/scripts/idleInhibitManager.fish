#!/usr/bin/env fish
set IDLE_INHIBIT_PID 0
# This counts how many players have started as to only stop the idle inhibition when all are stopped
set IDLE_INHIBIT_COUNT 0

playerctl status --follow | while read -l state
    switch $state
        case Playing
            if test $IDLE_INHIBIT_COUNT -eq 0
                systemd-inhibit \
                    --what="idle" \
                    --who="Music Player" \
                    --why="Audio playback" \
                    sleep infinity &

                set IDLE_INHIBIT_PID $last_pid
                echo "🔒 Idle inhibited (PID: $IDLE_INHIBIT_PID)"
            end
            set IDLE_INHIBIT_COUNT (math $IDLE_INHIBIT_COUNT + 1)

        case Paused Stopped
            if test $IDLE_INHIBIT_COUNT -eq 1
                test $IDLE_INHIBIT_PID -ne 0 && kill $IDLE_INHIBIT_PID
                set IDLE_INHIBIT_PID 0
                echo "🔓 Idle inhibition released"
            end
            if test $IDLE_INHIBIT_COUNT -ne 0
                set IDLE_INHIBIT_COUNT (math $IDLE_INHIBIT_COUNT - 1)
            end
    end
end
