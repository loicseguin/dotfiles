#
# ~/.bash_profile
#

# Get environment variables from ~/.profile
source "$HOME/.profile"

# Start X if it is not already running.
if [[ ! $DISPLAY && XDG_VTNR -le 2 ]]; then
    exec startx
fi

[[ -f ~/.bashrc ]] && . ~/.bashrc
