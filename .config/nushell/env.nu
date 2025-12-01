$env.config.show_banner = false
#$env.config.edit_mode = "vi"

$env.LANG = "en_US.UTF-8"
$env.LC_ALL = "en_US.UTF-8"

$env.EDITOR = "hx"
$env.config.buffer_editor = "hx"

$env.BROWSER = "zen"
$env.HOSTNAME = (uname | get nodename)

$env.TERM = "xterm-256color"

use std/util "path add"
path add "~/.cargo/bin"
path add "/opt/cuda/bin"
path add "~/.local/bin"

$env.PROMPT_COMMAND_RIGHT = {||
    let host_seg = ([
        (ansi reset)
        (ansi magenta)
        (hostname)
    ] | str join)

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $host_seg] | str join)
}

source ~/.config/nushell/secrets.nu
