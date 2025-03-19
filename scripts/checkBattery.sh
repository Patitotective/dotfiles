#!/bin/sh
acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
  read -r status capacity

  if [ "$status" = Discharging ] && [ "$capacity" -le 10 ]; then
    ~/scripts/onLowBattery.sh
  fi
}
