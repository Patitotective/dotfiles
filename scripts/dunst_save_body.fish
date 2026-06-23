#!/usr/bin/env fish
# used in ~/.config/dunst/dunstrc
if set -q DUNST_BODY
    echo $DUNST_BODY >$HOME/.config/dunst/body.tmp
end
