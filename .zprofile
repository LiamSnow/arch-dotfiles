
# Auto StartX
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
#	lock_file="/tmp/startx.lock"
#
#	if [ ! -f "$lock_file" ]; then
#		touch "$lock_file"
		exec startx
#	fi
fi

