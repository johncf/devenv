#!/bin/bash

prefix=`tmux show-options -g | grep '^prefix\>' | awk '{print $2}'`

if [[ $prefix == 'C-b' ]]; then
  new_prefix='C-a'
else
  new_prefix='C-b'
fi

tmux set -g prefix "$new_prefix"
tmux bind "$prefix" run "$0"
tmux bind "$new_prefix" send-prefix
