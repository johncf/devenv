#!/bin/bash
sudo date -s "$(wget -O /dev/null -S "http://www.google.com/" 2>&1 | sed -n 's/^[ ]*[dD]ate:[ ]*//p' | head -1l | awk '{print $1, $3, $2, $5, "GMT", $4 }' | sed 's/,//')"
