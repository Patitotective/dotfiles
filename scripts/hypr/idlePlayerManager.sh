#!/usr/bin/env bash
coproc bar {
  playerctl status --follow
}

while true; do
  read -r state <&"${bar[0]}"

  case "$state" in
  "Playing") ~/scripts/hypr/toggleIdle.fish false ;;
  "Paused") ~/scripts/hypr/toggleIdle.fish true ;;
  *) ;;
  esac
done
