#!/usr/bin/env fish
# Here we iterate over the config files in ~/.config/etc that should be in /etc
for file in (fd . ~/.config/etc --type file)
    # file is the path of the config file i, in it's correct path (under /etc)
    set etcFile (string split .config $file)[2] # Path after .config (~/.config/etc/... -> /etc/...)
    # dir is the parent dir of file
    set parentDir (path dirname $etcFile)
    sudo mkdir -p "$parentDir"
    sudo ln -fv "$file" "$etcFile" # Hard link the file from the HOME folder to /etc
end
