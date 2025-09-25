#!/bin/bash

while true; do
    # Get the current window tree from swaymsg and store it in a variable
    window_tree=$(swaymsg -t get_tree)

    # Check if the "Control System" title is focused
    focused_window=$(swaymsg -t get_tree | jq -r '.. | .nodes? // empty | .[] | select(.focused == true) | .id // empty')
    echo $focused_window
    # Output the result
    if [[ -z "$focused_window" || "$focused_window" == "null" || "$focused_window" == "[]" ]]; then
        echo "Control System is focused."
    else
        echo "Control System is not focused."
    fi

    # Wait for 1 second before checking again
    sleep 1
done
