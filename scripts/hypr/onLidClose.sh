#!/bin/bash
echo "0: $(date '+%Y-%m-%d %H:%M:%S')" >>~/scripts/hypr/log.txt
if [[ $(hyprctl -j monitors all | jq length) -eq 1 ]]; then
  echo "1: $(date '+%Y-%m-%d %H:%M:%S')" >>~/scripts/hypr/log.txt
  ~/scripts/hypr/lock.sh
  echo "2: $(date '+%Y-%m-%d %H:%M:%S')" >>~/scripts/hypr/log.txt
  ~/scripts/hypr/suspend.sh
  echo "3: $(date '+%Y-%m-%d %H:%M:%S')" >>~/scripts/hypr/log.txt
fi
