function yayinstall
    set pkgsToInstall (yay -Slq | fzf -i -q "$argv" --multi --preview 'yay -Si {1} | bat -n --color=always -l yaml')
    if test -n "$pkgsToInstall" # If pkgsToInstall is not empty
        echo "$pkgsToInstall"
        yay -S (string split -- " " "$pkgsToInstall")
    end
end

function yayremove
    set pkgsToRemove (yay -Qq | fzf -i -q "$argv" --multi --preview 'yay -Qi {1} | bat -n --color=always -l yaml')
    if test -n "$pkgsToRemove" # If pkgsToRemove is not empty
        echo "$pkgsToRemove"
        yay -Rns (string split -- " " "$pkgsToRemove")
    end
end

# Outputs installed pkgs, last installed first
function yaylist
    set installed (yay -Qq)
    set pkgs
    # TODO: make it actually list pkgs in order of installation
    # Probably because rg uses parallelism, it doesn't output in the same order
    # Should instead use sort with the installation time
    for pkg in (rg "\[ALPM\] installed (\w+)" /var/log/pacman.log --replace '$1' --no-line-number --only-matching)
        if contains $pkg $installed; and not contains $pkg $pkgs
            set -p pkgs $pkg
        end
    end
    echo (printf %s\n $pkgs | fzf -i -q "$argv" --multi --preview 'yay -Qi {1} | bat -n --color=always -l yaml')
end
