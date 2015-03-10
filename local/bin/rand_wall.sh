#!/bin/bash
l=( `ls /home/shared/walls/*.jpg` )
n=${#l[@]}
feh --bg-fill "${l[$((RANDOM % n))]}"

