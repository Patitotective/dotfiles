#!/bin/fish
# Based of https://github.com/JohnPiwinski/neovim-anywhere

set tmpdir /tmp/nvim-everywhere
set tmpfile "$tmpdir/$(date +'%y%m%d%H%M%S')"

mkdir -p $tmpdir
wl-paste --primary --no-newline >$tmpfile
# touch $tmpfile

chmod o-r $tmpfile # Make file only readable to you
kitty --class=nvim-everywhere --override confirm_os_window_close=0 nvim -n "+nnoremap q <cmd>wq<cr>" $tmpfile
# -n to disable swap-file
# +startinsert

set content (string trim <$tmpfile)
if string length -q $content
    printf %s\n $content | wl-copy -n
    # wtype may be dangerous with a big file
    # if test (string length $content) -lt 100
    #     wtype (wl-paste --no-newline)
    # end
end
