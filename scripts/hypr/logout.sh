#!/usr/bin/env bash
~/scripts/hypr/onExit.sh
loginctl terminate-user "$USER"
