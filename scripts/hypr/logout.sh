#!/bin/bash
~/scripts/hypr/onExit.sh
loginctl terminate-user "$USER"
