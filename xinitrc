#
# ~/.xinitrc
#

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
xset dpms 0 0 1200 &

# Set screensaver to start after 5 minutes of inactivity (handled by xss-lock)
xset s 300 0 &

# Reload Nvidia Settings
nvidia-settings --load-config-only &

# Hide mouse pointer when not in use
unclutter &

# Enable compositing
compton -f &

exec i3
