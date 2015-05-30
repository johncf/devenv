#!/bin/bash
msize=$1
isize=`python2 -c "print '%.1f' % (1.175*$1)"`
printf '\33]50;%s\007' "xft:MonacoB:pixelsize=${msize},xft:Inconsolata for Powerline:pixelsize=${isize}"
