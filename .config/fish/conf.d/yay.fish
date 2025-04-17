function yayinstall
    yay -Slq | fzf -i -q "$argv" --multi --preview 'yay -Si {1} | bat -n --color=always -l yaml' | xargs echo >/dev/stderr | xargs -ro yay -S
end
function yayremove
    yay -Qq | fzf -i -q "$argv" --multi --preview 'yay -Qi {1} | bat -n --color=always -l yaml' | xargs echo >/dev/stderr | xargs -ro yay -Rns
end
# Outputs installed pkgs, last installed first
# TODO make it actually check if the pkg is installed
function yaylist
    for i in $(yay -Qq)
        do
        grep "\[ALPM\] installed $i" /var/log/pacman.log
        done | sort -u | sed -e 's/\[ALPM\] installed //' -e 's/(.*$//'
    end
end
