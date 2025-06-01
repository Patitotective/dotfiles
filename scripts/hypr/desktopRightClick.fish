#!/bin/fish
set activeWindow (hyprctl activewindow)
if test "$activeWindow" = Invalid # No active window -> On the desktop
    ~/scripts/hypr/menu.fish
end
