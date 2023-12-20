#!/bin/bash

date --utc
curl -v "https://www.google.com/" 2>&1 | sed -n 's/^<[ ][dD]ate:[ ]*//p' | head -1l | awk '{print $1, $3, $2, $5, "GMT", $4 }' | sed 's/,//'

# sudo timedatectl status
# sudo timedatectl set-time "$(date +%a\ %F\ %T)"
