#!/bin/bash
man=$(rofi -dmenu -p 'man:' < ~/.cache/man_list)
[[ -z "$man" ]] || urxvtc -e nvim -u ~/.nvim/manrc -c "ViewDocMan $man"

