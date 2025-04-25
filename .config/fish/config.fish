fish_add_path /usr/local/sbin /usr/local/bin /usr/bin
fish_add_path ~/.nimble/bin

set -g fish_key_bindings fish_vi_key_bindings
# bind ctrl-v fish_clipboard_paste

# fzf.fish
set fzf_preview_dir_cmd eza --all --color=always
set fzf_diff_highlighter delta --paging=never --width=20
set fzf_history_time_format "%d-%m %H:%M:%S"
set fzf_preview_file_cmd ~/scripts/fzf-preview.sh

fzf_configure_bindings --directory=ctrl-f --variables=ctrl-alt-v

if status is-interactive

end
