#!/bin/bash
man=$(rofi -dmenu -p 'man:' < ~/.volatile/man_list)
[[ -z "$man" ]] || urxvtc -e nvim -u ~/.nvim/manrc -c "ViewDocMan $man"

