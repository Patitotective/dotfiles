fzf --fish | source

set -g FZF_DEFAULT_COMMAND "fd --follow --hidden --color=always . \$dir 2> /dev/null | sed '1d; s#^\./##'"
set -g FZF_CTRL_T_COMMAND "command fd --follow --type file  --hidden --color=always . \$dir 2> /dev/null | sed '1d; s#^\./##'"
set -g FZF_ALT_C_COMMAND "command fd --follow --type dir  --hidden --color=always . \$dir 2> /dev/null | sed '1d; s#^\./##'"
set -g FZF_DEFAULT_OPTS --ansi

# Taken from https://junegunn.github.io/fzf/shell-integration/
# Preview file content using bat (https://github.com/sharkdp/bat)
set -g FZF_CTRL_T_OPTS "
--walker-skip .git,node_modules,target
--preview '~/scripts/fzf-preview.sh {}'
--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-Y to copy the command into clipboard using pbcopy
set -g FZF_CTRL_R_OPTS "
--bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
--color header:italic
--header 'Press CTRL-SHIFT-C to copy command into clipboard'"

# Print tree structure in the preview window
set -g FZF_ALT_C_OPTS "
--walker-skip .git,node_modules,target
--preview 'fd . {} | tree --fromfile -C'"
