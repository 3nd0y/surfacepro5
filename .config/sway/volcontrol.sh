#!/bin/bash

# Function to get current volume
get_current_volume() {
    current_volume=$(amixer get Master | grep -oP '\d+(?=%)' | head -n 1)
    if [ -z "$current_volume" ]; then
        current_volume=50  # Default to 50% if amixer fails
    fi
    echo $current_volume
}

# Get initial volume value
current_volume=$(get_current_volume)

# Create the GUI with a slider for volume control
result=$(yad --title="Volume Control" \
             --width=350 \
             --height=200 \
             --scale="Volume Control" \
             --min-value=0 \
             --max-value=100 \
             --value=$current_volume \
             --step=1 \
             --button="OK:0" \
             --button="Cancel:1")

# Get the result (exit code and value)
exit_code=$?
if [[ $exit_code -eq 0 ]]; then
    amixer set Master "$result"%
fi
