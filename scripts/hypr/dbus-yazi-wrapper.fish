#!/usr/bin/env fish
# Based of https://github.com/boydaihungst/org.freedesktop.FileManager1.common/blob/f2eb1784815ebb9db9206d581dc51edc46622569/config/yazi-wrapper.sh
# By boydaihungst

# dbus_method can be ->
# ShowFolders = assumes that the specified URIs are folders; the file manager is supposed to show a window with the contents of each folder. Calling this method with file:///etc as the single element in the array of URIs will cause the file manager to show the contents of /etc as if the user had navigated to it. The behavior for more than one element is left up to the implementation; commonly, multiple windows will be shown, one for each folder.
# ShowItems = doesn't make any assumptions as to the type of the URIs. The file manager is supposed to select the passed items within their respective parent folders. Calling this method on file:///etc as the single element in the array of URIs will cause the file manager to show a file listing for "/", with "etc" highlighted. The behavior for more than one element is left up to the implementation.
# ShowItemProperties = should cause the file manager to show a "properties" window for the specified URIs. For local Unix files, these properties can be the file permissions, icon used for the files, and other metadata.
# Read more here: https://www.freedesktop.org/wiki/Specifications/file-manager-interface/

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
