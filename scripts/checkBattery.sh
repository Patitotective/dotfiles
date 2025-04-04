#!/bin/bash
acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
  read -r status capacity

  if [ "$status" = Charging ]; then
    rm -f ~/scripts/.10BatteryNotif
    rm -f ~/scripts/.40BatteryNotif
  elif [ "$status" = Discharging ]; then
    rm -f ~/scripts/.100BatteryNotif
    rm -f ~/scripts/.60BatteryNotif
  fi

  if [ "$status" = Discharging ] && [ "$capacity" -le 10 ] && [ ! -f ~/scripts/.10BatteryNotif ]; then
    notify-send -u critical -a "Power Management (user)" "Low Battery" "Plug your computer to avoid losing any work."
    touch ~/scripts/.10BatteryNotif
    mpv --loop=1 /usr/share/sounds/freedesktop/stereo/suspend-error.oga
  elif [ "$status" = Discharging ] && [ "$capacity" -le 40 ] && [ ! -f ~/scripts/.40BatteryNotif ]; then
    notify-send -u critical -a "Power Management (user)" "Battery At 40%" "Plug your computer."
    touch ~/scripts/.40BatteryNotif
    mpv /usr/share/sounds/ocean/stereo/outcome-failure.oga
  elif [ "$status" = Charging ] && [ "$capacity" -ge 60 ] && [ ! -f ~/scripts/.60BatteryNotif ]; then
    notify-send -u critical -a "Power Management (user)" "Battery At 60%" "Unplug your computer."
    touch ~/scripts/.60BatteryNotif
    mpv /usr/share/sounds/ocean/stereo/outcome-success.oga
  elif [ "$status" = Charging ] && [ "$capacity" -ge 100 ] && [ ! -f ~/scripts/.100BatteryNotif ]; then
    notify-send -u normal -a "Power Management (user)" "Fully Charged" "You may unplug your computer."
    touch ~/scripts/.100BatteryNotif
    mpv /usr/share/sounds/ocean/stereo/message-sent-instant.oga
  fi
}
