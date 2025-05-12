#!/bin/bash
mkdir -p ~/backup
yay -Qqen >~/backup/pkglist-native.txt
yay -Qqem >~/backup/pkglist-foreign.txt
echo Done ~/backup/pkglist-native.txt
echo Done ~/backup/pkglist-foreign.txt.txt
