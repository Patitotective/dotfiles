#!/bin/bash
mkdir -p ~/backup
yay -Qqen >~/backup/pkglist-native.txt
yay -Qqem >~/backup/pkglist-foreign.txt
