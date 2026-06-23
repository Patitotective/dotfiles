#!/usr/bin/env fish
# Based of https://github.com/andrewathalye/hyprland-2d/blob/fe3c29b464309a8cba75a8064fe20ea2632bd8bb/hypr_matrix.sh by andrewathalye

set size 3
set warp true

function clamp
    if test $argv[1] -ge $size
        if test $warp = true
            echo 0
        else
            echo (math $size - 1)
        end
    else if test $argv[1] -lt 0
        if test $warp = true
            echo (math $size - 1)
        else
            echo 0
        end
    else
        echo $argv[1]
    end
end

function getX
    math $argv[1] % $size
end

function getY
    math --scale 0 $argv[1] / $size
end

function show_all
    for id in (hyprctl workspaces -j | jq '.[]."id"' | sort -g)
        set -l id (math $id - 1) # Since hyprland's ids start from 1
        set -l x (getX $id)
        set -l y (getY $id)
        if test $x -ge 0 -a $x -lt $size -a $y -ge 0 -a $y -lt $size
            echo "$id = ($x, $y)"
        end
    end
end

set activeId (hyprctl monitors -j | jq '.[]."activeWorkspace"."id"')
set activeId (math $activeId - 1)

if test $activeId -gt (math $size ^ 2)
    switch $argv[1]
        case left
            hyprctl dispatch workspace -1
        case right
            hyprctl dispatch workspace +1
        case move_left
            hyprctl dispatch movetoworkspace -1
        case move_right
            hyprctl dispatch movetoworkspace +1
    end
    exit
end

set x (getX $activeId)
set y (getY $activeId)

switch $argv[1]
    case all
        show_all
        exit
    case left move_left
        set x (clamp (math $x - 1))
    case right move_right
        set x (clamp (math $x + 1))
    case up move_up
        set y (clamp (math $y - 1))
    case down move_down
        set y (clamp (math $y + 1))
    case query
        echo "($x,$y)"
        exit
end

set newId (math "($y * $size) + $x + 1") # Since hyprland's ids start from 1

switch $argv[1]
    case left right up down
        hyprctl dispatch workspace $newId
    case move_left move_right move_up move_down
        hyprctl dispatch movetoworkspace $newId
end
