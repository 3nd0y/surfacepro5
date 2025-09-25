#!/bin/bash

# Function to get current brightness
get_current_brightness() {
    current_brightness=$(brightnessctl get | awk '{print int($1/100)}')
    if [ -z "$current_brightness" ]; then
        current_brightness=50  # Default to 50% if brightnessctl fails
    fi
    echo $current_brightness
}

# Get initial brightness value
current_brightness=$(get_current_brightness)

# Create the GUI with a slider for brightness control
result=$(yad --title="Brightness Control" \
             --width=350 \
             --height=200 \
             --scale="Brightness Control" \
             --min-value=0 \
             --max-value=100 \
             --value=$current_brightness \
             --step=1 \
             --button="OK:0" \
             --button="Cancel:1")

# Debugging: Print the result to see what we are getting
echo "Result: $result"

# Extract the value from the result
exit_code=$?
if [[ $exit_code -eq 0 ]]; then
    # Extract the brightness value from the result
    brightness=$(echo "$result" | awk -F'|' '{print $1}')
    
    # Print brightness for debugging
    echo "Brightness Selected: $brightness"
    
    # Adjust brightness if changed
    if [[ ! -z "$brightness" ]]; then
        brightnessctl set $brightness%
    fi
fi
