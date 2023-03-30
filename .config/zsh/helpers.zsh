# Terminal simulator Blur {{{ Only for KDE
if [[ $(ps --no-header -p $PPID -o comm) =~ '^yakuake|alacritty|kitty|wezterm|wezterm-gui$' ]]; then
    for wid in $(xdotool search --pid $PPID); do
        xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid
    done
fi
# }}}

# Enable Transient Prompt
zle-line-init() {
    emulate -L zsh

    [[ $CONTEXT == start ]] || return 0

    while true; do
        zle .recursive-edit
        local -i ret=$?
        [[ $ret == 0 && $KEYS == $'\4' ]] || break
        [[ -o ignore_eof ]] || exit 0
    done

    local saved_prompt=$PROMPT
    local saved_rprompt=$RPROMPT
    PROMPT='$fg[green]❯ '
    RPROMPT=''
    zle .reset-prompt
    PROMPT=$saved_prompt
    RPROMPT=$saved_rprompt

    if ((ret)); then
        zle .send-break
    else
        zle .accept-line
    fi
    return ret
}
zle -N zle-line-init

# Automatically activate python virtual environments
auto_venv() {
  if [ -d "venv/bin" ]; then
    if [[ "$VIRTUAL_ENV" != "$(pwd -P)/venv" ]]; then
      source venv/bin/activate
    fi
  elif [[ "$VIRTUAL_ENV" != "" ]]; then
    deactivate
  fi
}

chpwd() {
  auto_venv
}
auto_venv
