#!/usr/bin/env bash

## Bspwm config directory
BSPDIR="$HOME/.config/bspwm"

## Polybar config directory
BARDIR="$HOME/.config/polybar"

## Wallpaper directory
WALLPAPERS="$HOME/Pictures/wallpapers/"

## AutoStart ---------------------------------------------#

# Kill if already running
killall -9 xsettingd sxhkd dunst ksuperkey xfce4-power-manager gnome-keyring-daemon

xautolock -time 45 -locker "betterlockscreen --lock blur" -detectsleep &

# polkit agent
if [[ ! $(pidof xfce-polkit) ]]; then
	/usr/lib/xfce-polkit/xfce-polkit &
fi

# Launch gnome-keyring-daemon
eval "$(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"

# Launch keybindings daemon
pgrep -x sxhkd > /dev/null || sxhkd -c "$BSPDIR/sxhkdrc" &

# Enable Super Keys For Menu
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_R|F1' &

# Enable power manager
xfce4-power-manager &

# Fix cursor
xsetroot -cursor_name left_ptr

# Restore wallpapers
feh --no-fehbg --bg-fill --randomize "$WALLPAPERS"

# Start polybar
"$BARDIR"/launch.sh &

# NetworkManager applet
nm-applet --sm-disable &
# nmcli device wifi connect OneplusSix password 12345678 &
# Picom
picom -b --experimental-backends &

# Clipboard
copyq &

# numlock
numlockx on &

# Start fcitx5
fcitx5 &

bspcolors
bspcomp
bspdunst
bspfloat &
