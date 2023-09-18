#!/usr/bin/env bash

capslock=$(cat /sys/class/leds/input25::capslock/brightness)
numlock=$(cat /sys/class/leds/input25::numlock/brightness)

if [[ "${capslock}" == "1" && "${numlock}" == "1" ]]; then
    echo "<span color='#fff'>󰪛 󰎠</span>"
elif [[ "${capslock}" == "1" && "${numlock}" == "0" ]]; then
    echo "<span color='#fff'>󰪛</span> <span color='#555'>󰎠</span>"
elif [[ "${capslock}" == "0" && "${numlock}" == "1" ]]; then
    echo "<span color='#555'>󰪛</span> <span color='#fff'>󰎠</span>"
else
    echo "<span color='#555'>󰪛 󰎠</span>"
fi
