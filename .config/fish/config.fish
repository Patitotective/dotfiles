fish_add_path /usr/local/sbin /usr/local/bin /usr/bin
fish_add_path ~/.nimble/bin
fish_add_path ~/.local/share/nvim/lazy/nvim_rocks/bin

set -g fish_key_bindings fish_vi_key_bindings

bind yy fish_clipboard_copy
bind p fish_clipboard_paste
# bind P fish_clipboard_paste # TODO: why does this not work? 😭

bind -M insert ctrl-w backward-kill-word
bind -M insert ctrl-x kill-word

bind -M insert ctrl-u backward-kill-line

bind -M insert ctrl-a beginning-of-line
bind -M insert ctrl-e end-of-line

bind -M insert ctrl-s backward-delete-char
bind -M insert ctrl-d delete-char

bind -M insert ctrl-f forward-word
bind -M insert ctrl-b backward-word

bind -M insert ctrl-y accept-autosuggestion
bind -M insert --erase ctrl-n

# TODO: make this bindings work by having kitty detect that fish is in insert mode...
bind -M insert ctrl-h backward-char
bind -M insert ctrl-l forward-char
bind -M insert ctrl-j down-line
bind -M insert ctrl-k up-line

# fzf.fish
set fzf_preview_dir_cmd eza --all --color=always
set fzf_diff_highlighter delta --paging=never --width=20
set fzf_history_time_format "%d-%m %H:%M:%S"
set fzf_preview_file_cmd ~/scripts/fzf-preview.sh
set fzf_fd_opts --hidden --no-ignore # --max-depth 5

fzf_configure_bindings --directory=ctrl-f --variables=ctrl-alt-v

alias onlyoffice="onlyoffice-desktopeditors --xdg-desktop-portal=default"
alias ls=eza
alias jless="jless --relative-line-numbers"
alias orgfiles="cd ~/Documents/orgfiles; nvim \"+lua require('persistence').load()\""

# if i run this then suddenly it won't show up
# tide configure --auto --style=Lean --prompt_colors='True color' --show_time='24-hour format' --lean_prompt_height='One line' --prompt_spacing=Compact --icons='Few icons' --transient=No

function back_to_normal --on-event fish_prompt
    fish_vi_key_bindings default
end

if status is-interactive
end
