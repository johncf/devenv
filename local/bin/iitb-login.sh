#!/bin/sh
curl -v -X POST "https://internet.iitb.ac.in/index.php" --data-urlencode "uname=<roll>" \
    --data-urlencode "passwd=<pass>" \
    --data-urlencode "button=Login" >& /dev/null \
  && echo "Successfully connected!" || echo "Connection failed!"
