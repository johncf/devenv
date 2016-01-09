#!/bin/bash

total=( $1 )
len0=0
len1=${#total[*]}
while [ $len0 -ne $len1 ]; do
    len0=$len1
    t1=( "${total[@]}" )
    t2=( `pacman -Qi "${t1[@]}" 2>/dev/null | \
          sed -n 's/Depends On.*: \(.*\)$/\1/p'` )
    t3=( "${t1[@]}" "${t2[@]}" )
    total=( $(echo "$(printf "\n%s" "${t3[@]}")" | \
              sed -e '/^None$/d' -e 's/^\([^><=]\+\).*/\1/' | \
              sort | uniq) )
    len1=${#total[*]}
done
pacman -Q "${total[@]}"
