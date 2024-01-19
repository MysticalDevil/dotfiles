#!/usr/bin/env zsh

function remove-types() {
    swc $1 -C jsc.target=esnext -d .
}
