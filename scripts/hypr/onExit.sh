#!/bin/bash
rm ~/scripts/hypr/.skipMonitorAddedEvent
# Save prev brightness
~/scripts/hypr/getBrightness.sh >~/scripts/hypr/.prevBrightness
# Set brightness to 100%
~/scripts/hypr/setBrightness.sh 1
