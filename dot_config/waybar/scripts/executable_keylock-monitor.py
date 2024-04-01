#!/usr/bin/env python3

import glob
import os
import re

leds = glob.glob("/sys/class/leds/input*")

caps_leds = []
num_leds = []

for led in leds:
    if re.search(r".*::capslock$", led):
        caps_leds.append(led)

    if re.search(r".*::numlock$", led):
        num_leds.append(led)

capslock = 0
numlock = 0

for i in range(len(caps_leds)):
    if os.path.exists(f"{caps_leds[i]}/brightness"):
        with open(f"{caps_leds[i]}/brightness") as f:
            capslock = int(f.read())

    if os.path.exists(f"{num_leds[i]}/brightness"):
        with open(f"{num_leds[i]}/brightness") as f:
            numlock = int(f.read())

if capslock == 0 and numlock == 0:
    print(
        '{"text": "<span color=\'#555\'>󰪛 󰎠</span>", "tooltip": "Numlock off. Capslock off."}'
    )
elif capslock == 0 and numlock == 1:
    print(
        '{"text": "<span color=\'#555\'>󰪛</span> <span color=\'#fff\'>󰎠</span>", "tooltip": "Capslock off. Numlock on."}'
    )
elif capslock == 1 and numlock == 0:
    print(
        '{"text": "<span color=\'#fff\'>󰪛</span> <span color=\'#555\'>󰎠</span>", "tooltip": "Capslock on. Numlock on."}'
    )
else:
    print(
        '{"text": "<span color=\'#fff\'>󰪛 󰎠</span>", "tooltip": "Capslock on. Numlock on"}'
    )
