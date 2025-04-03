# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    if (( ${+commands[curl]} )); then
        curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
            https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    else
        mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
            https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
    fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
    source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/cristobal/.zshrc'

# Commented out because zimfw told me to...
# autoload -Uz compinit
# compinit
# End of lines added by compinstall

# ------------ ZSH ------------
# utility to rename files in batch
autoload -U zmv

# ------------ PATH ------------
export PATH=$PATH:~/.nimble/bin
export EDITOR=/usr/bin/nvim

# ------------ NODE VERSION MANAGER ------------
source /usr/share/nvm/init-nvm.sh

# ------------ DOTFILES ------------
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
dotlazygit () { lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME }
# Filter through untracked files and add them
dotaddother () { dot ls-files -o | rg '(^(.config/)|(scripts/))|(^[^/]+$)' | fzf -m --ansi --preview '~/scripts/fzf-preview.sh {}' | sed '/^[[:space:]]*$/d' | xargs echo >/dev/stderr | while read -r i; do dot add "$i"; done }

# ------------ YAY ------------
yayinstall () { yay -Slq | fzf -i -q "$1" --multi --preview 'yay -Si {1} | bat -n --color=always -l yaml' | xargs echo >/dev/stderr | xargs -ro yay -S }
yayremove () { yay -Qq | fzf -i -q "$1" --multi --preview 'yay -Qi {1} | bat -n --color=always -l yaml' | xargs echo >/dev/stderr | xargs -ro yay -Rns }
# Outputs installed pkgs, last installed first
# TODO make it actually check if the pkg is installed
yaylist () {
    for i in $(yay -Qq)
    do
        grep "\[ALPM\] installed $i" /var/log/pacman.log
    done | \
        sort -u | \
        sed -e 's/\[ALPM\] installed //' -e 's/(.*$//'
}

# ------------ FZF ------------
export FZF_DEFAULT_COMMAND="fd --follow --hidden --color=always"
export FZF_CTRL_T_COMMAND="fd --type file --follow --hidden --color=always"
export FZF_ALT_C_COMMAND="fd --type dir --follow --hidden --color=always"
export FZF_DEFAULT_OPTS="--ansi"

# Taken from https://junegunn.github.io/fzf/shell-integration/
# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
--walker-skip .git,node_modules,target
--preview '~/scripts/fzf-preview.sh {}'
--bind 'ctrl-/:change-preview-window(down|hidden|)'"

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
--bind 'ctrl-y:execute-silent(echo -n {2..} | wl-copy)+abort'
--color header:italic
--header 'Press CTRL-Y to copy command into clipboard'"

# Print tree structure in the preview window
export FZF_ALT_C_OPTS="
--walker-skip .git,node_modules,target
--preview 'fd . {} | tree --fromfile -C'"
