#!/usr/bin/env bash

# # -o abg:d:
# VALID_ARGS=$(getopt --long set:,get -- "$@")
# # if ! VALID_ARGS; then
# if [[ $? -ne 0 ]]; then
#   exit 1
# fi
#
# eval set -- "$VALID_ARGS"
# while [ : ]; do
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
  case $1 in
  --get) # -b | --beta)
    if [[ -e ~/scripts/hypr/.numlockOn ]]; then
      echo true
    else
      echo false
    fi
    exit
    ;;
  --set)
    if [ "$1" = "true" ]; then
      touch ~/scripts/hypr/.numlockOn
    else
      rm ~/scripts/hypr/.numlockOn
    fi
    exit
    ;;
  --toggle)
    if [[ -e ~/scripts/hypr/.numlockOn ]]; then
      rm ~/scripts/hypr/.numlockOn
    else
      touch ~/scripts/hypr/.numlockOn
    fi
    exit
    ;;
  esac
done
if [[ "$1" == '--' ]]; then shift; fi
