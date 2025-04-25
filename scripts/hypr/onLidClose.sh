#!/bin/bash
if [[ $(hyprctl -j monitors all | jq length) -eq 1 ]]; then
  echo "before: $(date '+%Y-%m-%d %H:%M:%S')" >>~/scripts/hypr/log.txt
  ~/scripts/hypr/lock.sh
  echo "after lock: $(date '+%Y-%m-%d %H:%M:%S')" >>~/scripts/hypr/log.txt
  ~/scripts/hypr/suspend.sh
  echo "after suspend: $(date '+%Y-%m-%d %H:%M:%S')" >>~/scripts/hypr/log.txt
fi
