#!/usr/bin/env bash
# get_weather.sh

MAX_RETRIES=5
WAIT_SECONDS=2

for ((retry=1; retry<=MAX_RETRIES; retry++)); do
    response=$(curl -s -w "%{http_code}" "https://wttr.in/$1?format=1&m")
    code=${response: -3}

    if [ "$code" -ne 200 ]; then
        echo "{\"text\":\"error\", \"tooltip\":\"HTTP error $code\"}"
        exit 1
    fi

    text=$(curl -s "https://wttr.in/$1?format=1&m" | sed -E "s/\s+/ /g")
    tooltip=$(curl -s "https://wttr.in/$1?format=4&m" | sed -E "s/\s+/ /g")

    if [[ $text == *"Unknown location"* ]]; then
        echo '{"text": "error", "tooltip": "Unknown location"}'
        exit 1
    elif [ -n "$text" ] && [ -n "$tooltip" ]; then
        echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
        exit 0
    fi

    sleep $WAIT_SECONDS
done

echo '{"text": "error", "tooltip": "error"}'
