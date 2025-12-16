#!/usr/bin/env bash

if [ "${1:0:1}" = "-" ]; then
  volume="$(awk -v v="${1:1}" 'BEGIN { print v / 100}')"
  wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ "$volume-"
elif [ "${1:0:1}" = "+" ]; then
  volume="$(awk -v v="${1:1}" 'BEGIN { print v / 100}')"
  wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ "$volume+"
else
  volume="$(awk -v v="$1" 'BEGIN { print v / 100}')"
  wpctl set-volume -l 1 @DEFAULT_AUDIO_SOURCE@ "$volume"
fi
