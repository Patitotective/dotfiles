# If not running interactively, don't do anything
[[ $- != *i* ]] && return

addpath() {
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    PATH="${PATH:+"$PATH:"}$1"
  fi
}
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

addpath /usr/local/sbin
addpath /usr/local/bin
addpath /usr/bin
addpath ~/.local/bin
addpath ~/.nimble/bin
addpath ~/.local/share/nvim/lazy/nvim_rocks/bin
addpath ~/.local/share/nvim/mason/bin
addpath ~/go/bin
addpath ~/.cargo/bin

if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} && ${SHLVL} == [1,2] ]]; then
  shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
  exec fish $LOGIN_OPTION
fi
