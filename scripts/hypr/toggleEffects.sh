#!/usr/bin/env bash
HYPR_NOEFFECTS=$(hyprctl -j getoption animations:enabled | jq '.bool')
if [ "$HYPR_NOEFFECTS" = "true" ]; then
      # TODO: change to lua
      # move scripts to one folder again (and convert them to nushell?)
      hyprctl eval "\
      hl.config({general = {gaps_in = 0, gaps_out = 0, border_size = 1}, \
      animations = {enabled = 0}, \
      decoration = {shadow = {enabled = 0}, blur = {enabled = 0}, fullscreen_opacity = 1, \
            rounding = 0, active_opacity = 1, inactive_opacity = 1}, \
      })"
else
      hyprctl reload
fi
