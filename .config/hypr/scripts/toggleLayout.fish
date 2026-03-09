#!/usr/bin/env fish
set layouts dwindle master scrolling
set cur_layout (hyprctl -j getoption general:layout | jq --raw-output '.str')

set e 0
set matched false
for l in $layouts
    set e (math $e + 1)
    if test $l = $cur_layout
        set matched true
        break
    end
end

# set -S layouts
set -S cur_layout
set -S e
set -S matched

if test $matched = true
    if test $e -eq (count $layouts)
        hyprctl keyword general:layout $layouts[1]
    else
        hyprctl keyword general:layout $layouts[(math $e + 1)]
    end
else
    hyprctl keyword general:layout $layouts[1]
end
