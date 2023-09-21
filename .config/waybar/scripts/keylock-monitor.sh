#!/usr/bin/env bash

check_keyboard() {
    local capslock=$1
    local numlock=$2

    if [[ "$capslock" == "1" && "$numlock" == "1" ]]; then
        echo "<span color='#fff'>󰪛 󰎠</span>"
    elif [[ "$capslock" == "1" && "$numlock" == "0" ]]; then
        echo "<span color='#fff'>󰪛</span> <span color='#555'>󰎠</span>"
    elif [[ "$capslock" == "0" && "$numlock" == "1" ]]; then
        echo "<span color='#555'>󰪛</span> <span color='#fff'>󰎠</span>"
    else
        echo "<span color='#555'>󰪛 󰎠</span>"
    fi
}

capslock1=$(cat /sys/class/leds/input25::capslock/brightness)
numlock1=$(cat /sys/class/leds/input25::numlock/brightness)

capslock2=$(cat /sys/class/leds/input36::capslock/brightness)
numlock2=$(cat /sys/class/leds/input36::numlock/brightness)

check_keyboard "$capslock1" "$numlock1"
check_keyboard "$capslock2" "$numlock2"
