#!/bin/bash
l=( `ls ${HOME}/pics/walls/*.[jp][pn]g` )
n=${#l[@]}
feh --bg-fill "${l[$((RANDOM % n))]}"

