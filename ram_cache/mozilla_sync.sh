#!/bin/bash

# This script should be run either periodically or during log out.

if [[ -z $SCRATCH ]]; then
	echo "scratch directory is not set up!"
	exit
fi

static=~/mozilla.tar # where the profile should be backed up
link=~/.mozilla # link to the volatile folder
volatile=$SCRATCH/.mozilla # the volatile folder (target of link)

# if the volatile folder does not exist, create it and extract the profile to it
if [ ! -r $volatile ]; then
	mkdir -p -m744 $volatile
	[ -r $static ] && tar xf $static -C $volatile
fi

# if the link doesn't match, remove it
if [ -L $link ] && [[ "$(readlink $link)" != "$link" ]]; then
	rm $link
fi

# if the link doesn't exist, create it
if [ ! -L $link ]; then
	if ! ln -s $volatile $link; then
		echo "Error: Verify the symlink: $link"
		exit
	fi
fi

pushd $volatile>/dev/null
if [ -f .packed.tar ]; then # if .tar file exist, create a new one and sync
	rm .packed.tar
	tar -cf .packed.tar *
	rsync -v --inplace --no-whole-file .packed.tar $static
elif ! [ -z "`ls`" ]; then # else if folder is not empty, create a .tar file
	tar -cf .packed.tar *
fi

# if a backup tar file doesn't exist, copy the volatile tar back
[ -r $static ] || cp .packed.tar $static
popd>/dev/null

