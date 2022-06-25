#!/bin/bash

#https://wiki.archlinux.org/title/Polybar

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# ---

# Launch Polybar, using default config location ~/.config/polybar/config
# polybar -c ~/.config/polybar/config.ini mybar &

# ---

# Launch same bar on all monitors
# if type "xrandr"; then
#     for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#         MONITOR=$m polybar -c ~/.config/polybar/config.ini mybar &
#     done
# else
#     polybar -c ~/.config/polybar/config.ini mybar &
# fi

# ---

if [ $(xrandr --query | grep -c " connected") == "2" ] ; then
    polybar -c ~/.config/polybar/config.ini mybar &
    polybar -c ~/.config/polybar/config.ini secondary &
else
    polybar -c ~/.config/polybar/config.ini mybar &
fi

echo "Polybar launched..."
