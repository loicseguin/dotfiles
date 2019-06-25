#
# ~/.profile
#

# ENVIRONMENT VARIABLES
export HISTFILESIZE=10000
export HISTSIZE=10000
export EDITOR='vim'
export TERMINAL='/usr/local/bin/st'

# Colorful man pages
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m' # end the info box
export LESS_TERMCAP_so=$'\e[01;42;30m' # begin the info box
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;32m'

# PATH
export PATH="$PATH:$HOME/.local/bin"
