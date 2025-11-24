function countdown
    set seconds $argv[1]
    set start (math (date +%s) + $seconds)
    while test $start -ge (date +%s)
        set time (math $start - (date +%s))
        printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
    end
    mpv /usr/share/sounds/ocean/stereo/alarm-clock-elapsed.oga
end
