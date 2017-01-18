#!/bin/bash

set -e

if [ -z "${WALLS_HOME}" ]; then
    echo '$WALLS_HOME is not set!'
    exit
fi

l=( `ls ${WALLS_HOME}/*.[jp][pn]g` )
n=${#l[@]}
feh --bg-fill "${l[$((RANDOM % n))]}"
