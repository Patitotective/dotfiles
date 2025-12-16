#!/usr/bin/env fish
set inhibit_pid 0

playerctl status --follow | while read -l state
    switch $state
        case Playing
            if test $inhibit_pid -eq 0
                systemd-inhibit \
                    --what="idle" \
                    --who="Music Player" \
                    --why="Audio playback" \
                    sleep infinity &

                set inhibit_pid $last_pid
                echo Inhibiting
            end

        case Paused Stopped
            test $inhibit_pid -ne 0 && kill $inhibit_pid
            set inhibit_pid 0
    end
end
