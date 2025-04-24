#!/bin/bash

laptopMonitor="Chimei Innolux Corporation 0x1521"
externalMonitor="YSP MF215BH 0x00001A0A" # The one in my desktop
tvMonitor="Samsung Electric Company SAMSUNG 0x01000E00"

# Check if an array contains an element surrounded by quotes
# -> contains array value
contains() {
  local IFS='"' # Input Field Separators
  local array=$1
  local foundAll=false
  for value in "${@:1:}"; do
    local found=false
    for ele in "${array[@]}"; do
      if [[ $value == "$ele" ]]; then
        found=true
        foundAll=true
      fi
    if [[ ! $found ]]; then
      foundAll=false
      break
    fi 
    done
    # if [[ ! "${array[*]}" =~ ${IFS}${value}${IFS} ]]; then
    #   return 1
    # fi
  done
  if [[ $foundAll ]]; then
    return 0
  else
    return 1
  fi
  # return 0
}

# Get the current monitors from hyprctl and convert them into a bash array containing their descriptions
readarray -t currentMonitors < <(hyprctl -j monitors | jq --compact-output '[.[] | .description]')
if contains "${currentMonitors[@]}" 'Chimei Innolux Corporation 0x1521'; then
  echo "true"
else
  echo "false"
fi
if contains "${currentMonitors[@]}" 'Chimei'; then
  echo "true"
else
  echo "false"
fi
# items=$(hyprctl -j monitors | jq --raw-output --compact-output '[.[] | .description]')
# $items >>test.txt
