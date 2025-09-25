#!/usr/bin/sh
#
# @AUTHOR: Luca Leon Happel
# @DATE  : 2021-11-07 So 19:12 32
#

#######################################
# This function is called each time `motion-sensor` writes to stdout.
# Also, some config files affect this function.
# - if ~/.config/autoscreenrotate is set to true, the screen will be
#   rotated with the device
# - if ~/.config/disableinput is set to true, the keyboard and touchpad
#   will be disabled while the laptop is rotated other than normal
# Arguments:
#   The line that was written to stdout.
#######################################
function processnewcommand {
#	if ( ( $( cat ~/.config/autoscreenrotate ) = "false" ) )
#	then
#		exit
#	fi
	case $1 in
		"Accelerometer orientation changed: normal")
			echo "screen rotated to normal"
			sudo ./screenrotation.sh "normal"
			;;
		"Accelerometer orientation changed: bottom-up")
			echo "screen rotated to inverted"
			sudo ./screenrotation.sh "inverted"
			;;
		"Accelerometer orientation changed: left-up")
			echo "screen rotated to left"
			sudo ./screenrotation.sh "left"
			;;
		"Accelerometer orientation changed: right-up")
			echo "screen rotated to right"
			sudo ./screenrotation.sh "right"
			;;
	esac
}

sleep 3
pushd /home/fmukhtarif/.config/sway/scripts
export -f processnewcommand
monitor-sensor | xargs --replace=% bash -c 'processnewcommand "%"'
