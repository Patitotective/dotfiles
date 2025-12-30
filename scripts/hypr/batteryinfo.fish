#!/usr/bin/env fish
# Based off https://gist.github.com/ashish-kus/dd562b0bf5e8488a09e0b9c289f4574c by ashish-kus

function clamp
    # clamp number min_limit max_limit
    math "max($argv[2], min($argv[3], $argv[1]))"
end

set battery_info (string match -rg "Battery \d+: (\w+), (\d+)%" (acpi -b))
set bstatus $battery_info[1]
set percentage $battery_info[2]

if test "$bstatus" = Charging
    set charging_icons "󰢟" "󰂆" "󰂇" "󰂈" "󰢝" "󰂉" "󰢞" "󰂊" "󰂋" "󰂅"
    set icon_index (clamp (math --scale 0 "$percentage / 10") 1 10)
    set battery_icon $charging_icons[$icon_index]
else
    set battery_icons "󱃍" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹"
    set icon_index (clamp (math --scale 0 "$percentage / 10") 1 10)
    set battery_icon $battery_icons[$icon_index]
end

echo "$battery_icon $percentage%"
