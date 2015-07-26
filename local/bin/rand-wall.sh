#!/bin/bash
l=( `ls /home/shared/walls/*.[jp][pn]g` )
n=${#l[@]}
feh --bg-fill "${l[$((RANDOM % n))]}"

