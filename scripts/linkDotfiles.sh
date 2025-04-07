# Here we iterate over the config files in ~/.config/etc that should be in /etc
fd . ~/.config/etc --type file |
  while read -r i; do
    # file is the path of the config file i, in it's correct path (under /etc)
    file="${i#*\.config}" # Path after .config (~/.config/etc/... -> /etc/...)
    # dir is the parent dir of file
    dir="${file%/*}"
    mkdir -p "$dir"
    sudo ln -fv "$i" "$file" # Hard link the file from the HOME folder to /etc
  done
