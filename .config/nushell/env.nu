$env.config.show_banner = false
$env.config.edit_mode = "vi"

$env.EDITOR = "nvim"
$env.config.buffer_editor = "nvim"

$env.BROWSER = "zen"
$env.HOSTNAME = (uname | get nodename)
$env.TERM = "xterm-256color"
