#!/usr/bin/env bash
if [ -f ~/scripts/hypr/.prevBrightness ]; then
  # read -ra ARRAY <<<"$(cat ~/scripts/hypr/.prevBrightness)"
  brightness="$(cat ~/scripts/hypr/.prevBrightness)"
  busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Brightness d "$brightness"
  rm ~/scripts/hypr/.prevBrightness
fi
