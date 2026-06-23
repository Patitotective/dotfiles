#!/usr/bin/env fish
# used in ~/.config/hypr/core/binds.lua
# Launches or focuses the next instance of the app
# TODO: windows opened with fuzzel (from the desktop files) don't have the appropiate classes set (like yazi) so they won't be detected
# TODO: if there's a process that matches the id, but not the class
argparse e/titleEndsWith= t/title= c/class= l/launch= -- $argv
or return
if set -ql _flag_launch
    if set -ql _flag_class
        set windows (hyprctl -j clients | jq --raw-output '[.[] | select(.class=="'$_flag_class'")]') # Select all windows matching the class
    else if set -ql _flag_title
        set windows (hyprctl -j clients | jq --raw-output '[.[] | select(.title=="'$_flag_title'")]') # Select all windows matching the class
    else if set -ql _flag_titleEndsWith
        set windows (hyprctl -j clients | jq --raw-output '[.[] | select(.title|endswith("'$_flag_titleEndsWith'"))]') # Select all windows matching the class
    else
        return
    end

    set windowsLength (echo $windows | jq --raw-output 'length')

    if test $windowsLength -gt 0
        set windowsHistoryIds (echo $windows | jq --raw-output '.[] | .focusHistoryID')
        set windowsAddresses (echo $windows | jq --raw-output '.[] | .address')
        set activeWindowAddress (hyprctl -j activewindow | jq --raw-output '.address')

        set activeWindowIndex (contains --index $activeWindowAddress $windowsAddresses || echo 0)
        set nextIndex 1

        if test $activeWindowIndex -gt 0
            set nextIndex (math $activeWindowIndex + 1)
        end

        if test $nextIndex -gt (count $windowsAddresses)
            set nextIndex 1
        end

        set nextAddress (echo $windowsAddresses[$nextIndex])
        hyprctl dispatch focuswindow address:$nextAddress
    else
        eval $_flag_launch
    end
end
