#!/usr/bin/env bash

free -h | awk '/Mem/:{printf $3"\n"}'
