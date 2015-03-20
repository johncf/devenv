#!/bin/bash

# The initialisation script which ensures links.
# The following links will be created, if doesn't exist:
#  $HOME/scratch -> /dev/shm/name_tmp
#  $HOME/.cache -> /dev/shm/name_tmp/.cache
# where 'name' is the user name

SCRATCH=/dev/shm/$USER"_tmp" # alternatively use /tmp/

[[ -d $SCRATCH ]] || mkdir -p -m744 $SCRATCH
[[ -L ~/scratch ]] || ln -s $SCRATCH ~/scratch

cache_dir=$SCRATCH/.cache
[[ -d $cache_dir ]] || mkdir -p -m744 $cache_dir
[[ -L ~/.cache ]] || ln -s $cache_dir ~/

export SCRATCH
bash ~/.local/bin/moz_sync.sh # for syncing the $HOME/.mozilla

