#!/bin/bash
test -t 0 && exec < <(printf '%s\n' "$@")
while IFS= read -r line; do
    echo "$line"
done
