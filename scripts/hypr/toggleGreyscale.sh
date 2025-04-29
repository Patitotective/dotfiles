#!/bin/bash
current=$(hyprctl -j getoption decoration:screen_shader | jq --raw-output '.str')

if [[ "$current" =~ (blank|EMPTY) ]] || [[ "$current" == "" ]]; then
  hyprctl keyword decoration:screen_shader ~/.config/hypr/greyscale.glsl
else
  hyprctl keyword decoration:screen_shader ~/.config/hypr/blank.glsl
fi
