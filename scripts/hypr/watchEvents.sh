#!/bin/sh

handle() {
  ~/scripts/hypr/handleEvents "$@"
  # case $1 in
  # *) do_something ;;
  # esac
}

socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r line; do handle "$line"; done
