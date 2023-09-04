#!/usr/bin/env bash
# get_weather.sh

for _ in {1..5}; do
  response=$(curl -s -w "%{http_code}" "https://wttr.in/$1?format=1&m")
  code=$(echo "$response" | tail -n1)
  if [ "$code" -ne 200 ]; then
    echo "{\"text\":\"error\", \"tooltip\":\"HTTP error $code\"}}"
    exit 1
  fi
  text=$(echo "$response" | head -n-1)
  if text=$(curl -s "https://wttr.in/$1?format=1&m"); then
    text=$(echo "$text" | sed -E "s/\s+/ /g")
    if tooltip=$(curl -s "https://wttr.in/$1?format=4&m"); then
      tooltip=$(echo "$tooltip" | sed -E "s/\s+/ /g")
      echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
      exit
    fi
  fi

  sleep 2
done
echo "{\"text\":\"error\", \"tooltip\":\"error\"}"
