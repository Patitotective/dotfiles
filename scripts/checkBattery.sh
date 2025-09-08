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
    dunstify --urgency=critical --icon="/usr/share/icons/Tela-purple/16/panel/battery-010.svg" "Low Battery" "Battery is on or below 10%. Charge your computer to avoid losing any work."
    touch ~/scripts/.10BatteryNotif
    mpv --loop=1 /usr/share/sounds/freedesktop/stereo/suspend-error.oga
  elif [ "$status" = Discharging ] && [ "$capacity" -le 40 ] && [ ! -f ~/scripts/.40BatteryNotif ]; then
    dunstify --icon="/usr/share/icons/Tela-purple/16/panel/battery-040.svg" "Battery is at or below 40%" "Plug the computer to prolong the battery's life."
    touch ~/scripts/.40BatteryNotif
    mpv /usr/share/sounds/ocean/stereo/outcome-failure.oga
  elif [ "$status" = Charging ] && [ "$capacity" -ge 100 ] && [ ! -f ~/scripts/.100BatteryNotif ]; then
    dunstify --icon="/usr/share/icons/Tela-purple/16/panel/battery-100-charging.svg" "Battery is fully charged" "Unplug the computer to prolong the battery's life."
    touch ~/scripts/.100BatteryNotif
    mpv /usr/share/sounds/ocean/stereo/message-sent-instant.oga
  elif [ "$status" = Charging ] && [ "$capacity" -ge 60 ] && [ ! -f ~/scripts/.60BatteryNotif ]; then
    dunstify --icon="/usr/share/icons/Tela-purple/16/panel/battery-060-charging.svg" "Battery is at or above 60%" "Unplug the computer to prolong the battery's life."
    touch ~/scripts/.60BatteryNotif
    mpv /usr/share/sounds/ocean/stereo/outcome-success.oga
  fi
}
