#!/usr/bin/env bash
layout=$(hyprctl -j getoption general:layout | jq --raw-output '.str')
echo "$layout"
if [[ $layout = "dwindle" ]]; then
  hyprctl keyword general:layout master
else
  hyprctl keyword general:layout dwindle
fi
