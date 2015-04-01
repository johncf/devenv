#!/bin/bash

if [ "$#" -lt 2 ]; then
	echo "Usage $0 <user_name> <tty>"
	exit 1
fi

c_red='\e[1;31m'
c_gre='\e[1;32m'
c_nil='\e[0m' # No Color

user=$1
tty=$2

#echo -ne "${c_gre}> ${c_nil}"
while read line; do
	echo -e "${c_red}${user}:${c_nil} ${line}">$tty
done
