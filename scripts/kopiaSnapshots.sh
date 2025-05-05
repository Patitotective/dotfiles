#!/bin/bash
kopia snapshot create "/usr/share/fonts"
kopia snapshot create "/usr/local/share/fonts"
kopia snapshot create "$HOME/Videos"
kopia snapshot create "$HOME/Pictures"
kopia snapshot create "$HOME/Music"
kopia snapshot create "$HOME/Documents"
kopia snapshot create "$HOME/.local/share/fonts"
