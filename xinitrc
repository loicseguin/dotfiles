#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Set Canadian multilingual keyboard
setxkbmap -layout "ca" -variant "multix" -option "ctrl:nocaps" &

# Set keyboard repeat rate
# First number is delay in milliseconds before repetition starts, second number
# is the number of repeats per second (see xset(1) for details).
xset r rate 220 40 &

# Desktop wallpaper
~/.fehbg &

# Enable compositing
picom -c &

exec i3
