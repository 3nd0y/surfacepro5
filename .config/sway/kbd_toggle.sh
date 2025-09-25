#!/bin/bash

# Check display rotation
output=swaymsg -t get_outputs | jq -r '.[] | "\(.transform)"'

# Check if wvkbd-mobintl is already running
if pgrep -x "wvkbd-mobintl" > /dev/null
then
    # If running, kill the process (remove keyboard)
    pkill wvkbd-mobintl
else
    # If not running, launch the virtual keyboard
    if [[ $output -eq 270 || $output -eq 90 ]] ; then
       wvkbd-mobintl -L 900 &
    else
       wvkbd-mobintl -L 300 &
    fi
fi
