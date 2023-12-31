#!/usr/bin/env bash

(checkupdates;pacman -Qm | aur vercmp) | wc -l
