#!/usr/bin/env fish

set dbus_method $argv[1]
for arg in $argv[2..-1]
    # To unescape URI escape sequences (%xx) with printf
    set -a items (printf '%b' (string replace '%' '\\x' $arg))
end

set cmd /usr/bin/yazi
set termcmd "/usr/bin/kitty --class yazi"
if set -q TERMCMD
    set termcmd $TERMCMD
end

# Since fish doesn't support invoking functions to the background yet
# By weisi from https://github.com/fish-shell/fish-shell/issues/238#issuecomment-1015806466
function bgFunc
    fish -c (string join -- ' ' (string escape -- $argv)) &
end

switch $dbus_method
    case ShowFolders ShowItems
        # NVIM_CWD's value is irrelevant, it tells yazi to not load the saved project
        eval "NVIM_CWD=abc $termcmd -- $cmd $items"
    case ShowItemProperties
        set -l yazi_id 999999
        bgFunc eval "NVIM_CWD=abc $termcmd -- $cmd --client-id $yazi_id $items"
        disown
        sleep 0.5
        ya emit-to $yazi_id spot
end
