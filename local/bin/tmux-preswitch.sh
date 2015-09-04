#!/bin/bash

prefix=`tmux show-options -g | grep '^prefix\>' | awk '{print $2}'`

if [[ $prefix == 'C-Space' ]]; then
  new_prefix='C-f'
else
  new_prefix='C-Space'
fi

tmux set -g prefix "$new_prefix"
tmux bind   "$prefix" run "$0"
tmux unbind "${prefix#C-}"
tmux bind   "$new_prefix" copy-mode
tmux bind   "${new_prefix#C-}" send-prefix
