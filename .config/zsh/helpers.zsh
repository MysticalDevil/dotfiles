# Enable Transient Prompt
function zle-line-init {
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

function set_wayland_env {
  cd ${HOME}
  export LANG=zh_CN.UTF-8
  export QT_AUTO_SCREEN_SCALE_FACTOR=1
  export QT_QPA_PLATFORM="wayland;xcb"
  export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

  export _JAVA_AWT_WM_NONEREPARENTING=1
  export GDK_BACKEND="wayland,x11"
}
set_wayland_env
