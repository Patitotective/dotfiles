function yayinstall
    set pkgsToInstall (yay -Slq | fzf -i -q "$argv" --multi --preview 'yay -Si {1} | bat -n --color=always -l yaml')
    if test -n "$pkgsToInstall" # If pkgsToInstall is not empty
        echo "$pkgsToInstall"
        yay -S "$pkgsToInstall"
    end

end
function yayremove
    set pkgsToRemove (yay -Qq | fzf -i -q "$argv" --multi --preview 'yay -Qi {1} | bat -n --color=always -l yaml')
    if test -n "$pkgsToRemove" # If pkgsToRemove is not empty
        echo "$pkgsToRemove"
        yay -Rns "$pkgsToRemove"
    end
end

# Outputs installed pkgs, last installed first
# TODO: make it actually check if the pkg is installed
# TODO: doesnt work in fish
# function yaylist
#     for i in $(yay -Qq)
#         do
#         grep "\[ALPM\] installed $i" /var/log/pacman.log
#         done | sort -u | sed -e 's/\[ALPM\] installed //' -e 's/(.*$//'
#     end
# end
