if (($env | get -i DISPLAY | default "") == "") and ((tty | str trim) == "/dev/tty1") {
    let config_file = $".config/hypr/(uname | get nodename).conf"
    print Hyprland Config: $config_file
    # exec Hyprland --config $config_file
}
