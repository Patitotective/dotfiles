#!/bin/bash
raw_brightness="$(busctl --user -- get-property rs.wl-gammarelay / rs.wl.gammarelay Brightness)" # d 0.5
brightness="$(echo "$raw_brightness" | cut -d' ' -f2)"                                           # 0.5
echo "$brightness"
