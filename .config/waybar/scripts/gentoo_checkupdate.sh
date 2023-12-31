#!/usr/bin/env bash

function eix-check() {
    check=$(eix --installed --upgrade --format --world '<installedversions:NAMEVERSION>')

    if [[ $check == *"No matches"* ]]; then
        echo 0
    else
        echo "$check" | head -n -1 | wc -l
    fi
}

eix-check
