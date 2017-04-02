#!/bin/bash

set -e

. ~/.config/machine

if [ -z "${WALLS_HOME}" ]; then
    echo '$WALLS_HOME is not set!' >&2
    exit
fi

readarray -t l <<< "`ls "$WALLS_HOME/"*.[jp][pn]g`"
n=${#l[@]}
feh --bg-fill "${l[$((RANDOM % n))]}"
