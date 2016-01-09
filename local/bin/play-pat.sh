#!/bin/bash

ag --ignore '(jpg|png|txt)$' -ig "$@" | \
  sed '/\(jpg\|png\|txt\|zip\|pdf\)$/Id' | {
    files=()
    while read line; do
        files+=("$line")
    done
    if [[ ${#files[@]} == 0 ]]; then
        echo "No files found matching pattern"
        exit
    fi
    echo "Found ${#files[@]} matches..."
    vlc "${files[@]}" 2>/dev/null &
}
