
# Auto Hyprland
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  HOSTNAME=$(uname -n)
  exec Hyprland --config ~/.config/hypr/$HOSTNAME.conf
fi
#
