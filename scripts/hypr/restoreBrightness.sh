#!/bin/bash
if [ -f ~/scripts/hypr/.prevBrightness ]; then
  read -ra ARRAY <<<"$(cat ~/scripts/hypr/.prevBrightness)"
  busctl --user set-property rs.wl-gammarelay / rs.wl.gammarelay Brightness "${ARRAY[0]}" "${ARRAY[1]}"
fi
