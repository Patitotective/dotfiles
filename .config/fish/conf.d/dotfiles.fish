function dot
    /usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv
end
function dotlazygit
    lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME $argv
end
# Filter through untracked files and add them
function dotaddother
    dot ls-files -o |
        rg '^(.config/)|^(scripts/)' |
        # rg '(^(.config/)|(scripts/))|(^[^/]+$)' |
        fzf -m --ansi --preview '~/scripts/fzf-preview.sh {}' |
        sed '/^[[:space:]]*$/d' |
        xargs echo >/dev/stderr | # TODO: does this really work...?
        while read -r i

            do dot add "$i"
        end
end
