#!/bin/bash

# Get the list of outputs from swaymsg in JSON format
outputs=$(swaymsg -t get_outputs)

# Loop through each output and extract its rotation
echo "$outputs" | jq -r '.[] | "\(.name) rotation: \(.rotation)"'
