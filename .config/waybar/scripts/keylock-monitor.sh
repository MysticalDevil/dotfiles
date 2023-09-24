#!/usr/bin/env bash

# Get list of input leds
mapfile -t leds < <(find /sys/class/leds/ | grep -E "/sys/class/leds/input[^/]+$")

capsleds=()
numleds=()
for led in "${leds[@]}"; do
    # Get caps lock leds
    if [[ "$led" =~ .*::capslock$ ]]; then
        capsleds+=("$led")
    fi

    # Get caps lock leds
    if [[ "$led" =~ .*::numlock$ ]]; then
        numleds+=("$led")
    fi
done

capslock=0
numlock=0
# Loop through caps and num lock leds
for ((i=0; i<${#capsleds[@]}; i++)); do

    # Check if caps lock led file exists
    if [ -f "${capsleds[$i]}/brightness" ]; then
        # Read brightness status
        capslock=$(cat "${capsleds[$i]}/brightness")
    fi

    # Check if num lock led file exists
    if [ -f "${numleds[$i]}/brightness" ]; then
        # Read brightness status
        numlock=$(cat "${numleds[$i]}/brightness")
    fi
done

# Print icon based on caps and num lock state
if [[ "$capslock" == "0" && "$numlock" == "0" ]]; then
    echo "<span color='#555'>󰪛 󰎠</span>"

elif [[ "$capslock" == "0" && "$numlock" == "1" ]]; then
    echo "<span color='#555'>󰪛</span> <span color='#fff'>󰎠</span>"

elif [[ "$capslock" == "1" && "$numlock" == "0" ]]; then
    echo "<span color='#fff'>󰪛</span> <span color='#555'>󰎠</span>"

else
    echo "<span color='#fff'>󰪛 󰎠</span>"
fi
