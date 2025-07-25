#!/bin/fish
# Based of https://github.com/kurealnum/dotfiles
# References: Fernando Cejas (https://fernandocejas.com/blog/engineering/2022-03-30-arch-linux-system-maintance/)

echo
echo ----------------------------------------------------
echo "BACKUP PACMAN PKGS LIST"
echo ----------------------------------------------------
~/scripts/backupPkgs.sh
echo "Backed up native and foreign packages successfully"

echo
echo ----------------------------------------------------
echo "BACKUP PACMAN DATABASE"
echo ----------------------------------------------------
mkdir -p ~/backup
tar -cjf ~/backup/pacman_database.tar.bz2 /var/lib/pacman/local
echo "Backed up pacman database"

echo
echo ----------------------------------------------------
echo "SYSTEMCTL FAILED UNITS"
echo ----------------------------------------------------
systemctl --failed

echo
echo ----------------------------------------------------
echo "JOURNAL ERRORS"
echo ----------------------------------------------------
journalctl --no-pager -b -p err

echo
echo ----------------------------------------------------
echo UNOWNED FILES
echo ----------------------------------------------------
set lostfiles (sudo lostfiles)
if test (count $lostfiles) -gt 0
    echo "Check and remove these unowned files"
    echo $lostfiles
else
    echo "No unowned files"
end

echo ----------------------------------------------------
echo "UPDATING SYSTEM"
echo ----------------------------------------------------

yay -Syu

echo
echo ----------------------------------------------------
echo "CLEARING PACMAN CACHE"
echo ----------------------------------------------------

set pacman_cache_space_used (du -sh /var/cache/pacman/pkg/)
echo "Space currently in use: $pacman_cache_space_used"
echo
echo "Clearing Cache, leaving newest 2 versions:"
paccache -vrk2
echo
echo "Clearing all uninstalled packages:"
paccache -ruk0

echo
echo ----------------------------------------------------
echo "REMOVING ORPHANED PACKAGES"
echo ----------------------------------------------------

# Orphans are packages that were installed as a dependency and are no longer required by any package.
set orphaned (yay -Qdtq)

if test (count $orphaned) -gt 0
    yay -Rns $orphaned
else
    echo "No orphaned packages to remove."
end

echo
echo ----------------------------------------------------
echo "CLEARING HOME CACHE"
echo ----------------------------------------------------

set home_cache_used "$(sudo du -sh ~/.cache)"
rm -rf ~/.cache/

echo "Clearing ~/.cache/..."
echo "Spaced saved: $home_cache_used"

echo
echo ----------------------------------------------------
echo "CLEARING SYSTEM LOGS"
echo ----------------------------------------------------

sudo journalctl --vacuum-time=1y

echo
echo ----------------------------------------------------
echo "UPDATING FISH COMPLETIONS"
echo ----------------------------------------------------

fish -c fish_update_completions

echo
echo ----------------------------------------------------
echo "UPDATING FISHER"
echo ----------------------------------------------------

fish -c "fisher update"

echo
echo ----------------------------------------------------
echo "UPDATING YAZI PLUGINS"
echo ----------------------------------------------------

ya pkg upgrade

echo
echo ----------------------------------------------------
echo "GENERATING ORGFILES INDEX"
echo ----------------------------------------------------

~/dev/snippets/makeOrgfilesIndex

echo
echo ----------------------------------------------------
echo "KOPIA MANTEINANCE"
echo ----------------------------------------------------

kopia maintenance run --full
