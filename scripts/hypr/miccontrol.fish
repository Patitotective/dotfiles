#!/usr/bin/env fish
# used in ~/.config/waybar/config.jsonc

if test "$argv[1]" = mute
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1
else if test "$argv[1]" = unmute
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0
else if test "$argv[1]" = toggle
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
else
    switch (string sub --length 1 -- "$argv[1]")
        case -
            wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ -- "$(string sub --start=2 -- $argv[1])-"
        case +
            wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ -- "$(string sub --start=2 -- $argv[1])+"
        case 1 2 3 4 5 6 7 8 9 0
            wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ -- "$argv[1]"
    end
end
