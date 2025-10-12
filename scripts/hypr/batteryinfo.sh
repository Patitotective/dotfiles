#!/usr/bin/env bash
# Based off https://gist.github.com/ashish-kus/dd562b0bf5e8488a09e0b9c289f4574c by ashish-kus

# Get the current battery percentage
battery_percentage=$(acpi -b | awk -F'[,:%]' '{print $3}' | xargs)

# Get the battery status (Charging or Discharging)
battery_status=$(acpi -b | awk -F'[,:%]' '{print $2}' | xargs)

# Define the battery icons for each 10% segment
battery_icons=("󱃍" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

# Define the charging icon
charging_icons=("󰢟" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅")

# Calculate the index for the icon array
icon_index=$((battery_percentage / 10))

# Get the corresponding icon
battery_icon=${battery_icons[icon_index]}

# Calculate the index for the icon array
charging_icons_index=$((battery_percentage / 10))

# Get the corresponding icon
charging_battery_icon=${charging_icons[charging_icons_index]}

# Check if the battery is charging
if [ "$battery_status" = "Charging" ]; then
  battery_icon="$charging_battery_icon"
fi

# Output the battery percentage and icon
echo "$battery_icon $battery_percentage%"
