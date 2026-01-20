#!/usr/bin/env bash
# Relative changes +0.5, -0.5
if [ "${1:0:1}" = "+" ] || [ "${1:0:1}" = "-" ]; then
  busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay UpdateBrightness d "$1"
# Division changes /2, /3
elif [ "${1:0:1}" = "/" ]; then
  prev_brightness="$(~/scripts/hypr/getBrightness.sh)"
  num="${1:1}"
  new_brightness="$(awk -v p="$prev_brightness" -v n="$num" 'BEGIN { print p / n}')"
  busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Brightness d "$new_brightness"
# Multiplication changes *2, *3
elif [ "${1:0:1}" = "*" ]; then
  prev_brightness="$(~/scripts/hypr/getBrightness.sh)"
  num="${1:1}"
  new_brightness="$(awk -v p="$prev_brightness" -v n="$num" 'BEGIN { print p * n}')"
  busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Brightness d "$new_brightness"
# Absolute changes, 1, 0
else
  busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Brightness d "$1"
fi

# Don't allow for 0 or lower brightness
new_brightness="$(~/scripts/hypr/getBrightness.sh)"
if awk "BEGIN {exit !($new_brightness < 0.02)}"; then # https://stackoverflow.com/a/45591665
  busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Brightness d 0.02
fi
