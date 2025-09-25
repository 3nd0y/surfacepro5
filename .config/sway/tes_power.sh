#!/bin/bash

choice=$(echo -e "Terminal\nShutdown\nReboot\nLog Out" | wofi --dmenu --prompt "Power")

wvkbd -L 300
