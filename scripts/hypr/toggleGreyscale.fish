#!/bin/fish
# shader[0] is set and shader[1] is str
set shader (hyprctl -j getoption decoration:screen_shader | jq --raw-output '.set, .str')
set greyscale ~/.config/hypr/shaders/greyscale.glsl
set blank ~/.config/hypr/shaders/blank.glsl

if test $shader[1] = false -o $shader[2] = $blank -o $shader[2] = blank -o $shader[2] = "[[EMPTY]]"
    hyprctl keyword decoration:screen_shader $greyscale
else
    hyprctl keyword decoration:screen_shader $blank
end
