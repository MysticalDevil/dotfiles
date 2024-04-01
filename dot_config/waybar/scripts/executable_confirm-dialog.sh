#!/usr/bin/env bash

type=$1

zenity --question --title="Warning" --text="Are you sure ou want to $type?"
response=$?

if [ "$response" = "0" ]; then
    if [ "$type" = "reboot" ]; then
        reboot
    fi
    if [ "$type" = "shutdown" ]; then
        shutdown now
    fi
fi
exit 0
