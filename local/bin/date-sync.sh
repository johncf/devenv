#!/bin/bash

sudo date -s "$(curl -v "http://www.google.com/" 2>&1 >/dev/null | sed -n 's/^<[ ][dD]ate:[ ]*//p' | head -1l | awk '{print $1, $3, $2, $5, "GMT", $4 }' | sed 's/,//')"

# sudo timedatectl status
# sudo timedatectl set-time "$(date +%a\ %F\ %T)"
