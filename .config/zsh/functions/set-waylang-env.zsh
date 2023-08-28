function set_wayland_env {
  cd ${HOME}
  export LANG=zh_CN.UTF-8
  export QT_AUTO_SCREEN_SCALE_FACTOR=1
  export QT_QPA_PLATFORM="wayland;xcb"
  export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
  export QT_QPA_PLATFORMTHEME=qt5ct
  export QT_STYLE_OVERRIDE=kvantum

  # export _JAVA_AWT_WM_NONEREPARENTING=1
  export GDK_BACKEND="wayland,x11"
}
set_wayland_env
