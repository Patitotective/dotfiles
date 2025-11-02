#!/usr/bin/env fish
set fonts
for f in $argv
    set -a fonts (path basename "$f")
end

font-manager --install $argv
and dunstify --icon="/usr/share/icons/Tela-purple/symbolic/categories/applications-fonts-symbolic.svg" \
    "Successfully Installed Fonts" "$(string join '\n' $fonts)"
