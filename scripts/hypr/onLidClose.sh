#!/bin/bash
if [[ $(hyprctl -j monitors all | jq length) -eq 1 ]]; then
  ~/scripts/hypr/lock.sh
  ~/scripts/hypr/suspend.sh
fi
