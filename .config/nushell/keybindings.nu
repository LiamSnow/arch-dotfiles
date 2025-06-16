$env.config = ($env.config | upsert keybindings [
  {
    name: move_to_line_end_or_take_history_hint
    modifier: control
    keycode: char_f
    mode: [emacs, vi_normal, vi_insert]
    event: {
      until: [
        {send: historyhintcomplete}
        {edit: movetolineend}
      ]
    }
  }
  {
    name: move_one_word_right_or_take_history_hint
    modifier: alt
    keycode: char_f
    mode: [emacs, vi_normal, vi_insert]
    event: {
      until: [
        {send: historyhintwordcomplete}
        {edit: movewordright}
      ]
    }
  }
  {
    name: cd_back
    modifier: control
    keycode: char_d
    mode: [emacs, vi_normal, vi_insert]
    event: {
      send: executehostcommand,
      cmd: "cd .."
    }
  }
])
