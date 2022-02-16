#
# ~/.xinitrc
#

# Load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Display configuration (from arandr)
#xrandr --output DVI-D-0 --mode 1680x1050 --pos 0x0 --rotate normal --output HDMI-0 --primary --mode 2560x1080 --pos 1680x0 --rotate normal --output DP-0 --off --output DP-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --off --output DP-5 --off

# Set Canadian multilingual keyboard
setxkbmap -layout "ca(multi)" &

# Keyboard repeat rate
# First number is delay in milliseconds before repetition starts, second number
# is the number of repeats per second (see xset(1) for details).
xset r rate 220 40 &

# DPMS settings
# Times in second before monitor state set to standby/suspend/off. On my
# monitors, standy does not work, and suspend is the same as off, hence,
# deactivate these two modes by setting them to 0.
#xset dpms 0 0 1200 &

# Set screensaver to start after 5 minutes of inactivity (handled by xss-lock)
#xset s 300 0 &

# Reload Nvidia Settings
nvidia-settings --load-config-only &

# Hide mouse pointer when not in use
#unclutter &

# Enable compositing
picom -c &

exec i3
#exec bspwm
#exec openbox-session

