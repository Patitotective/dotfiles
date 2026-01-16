#!/usr/bin/env fish
if set -q DUNST_BODY
    echo $DUNST_BODY >$HOME/.config/dunst/body.tmp
end
