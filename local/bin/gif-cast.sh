#!/bin/bash

# Requirements:
#   * xwininfo
#   * recordmydesktop
#   * mplayer
#   * imagemagick

if [ -z "$1" ]; then
    echo "Usage: $0 <gif-file>"
    exit
fi

gif="$1"
jpgs="${gif}.jpgs"
mkdir "${jpgs}" || exit

echo "Click on the window you want to record!"
echo "Recording will start exactly one second after you click the window."
echo "Press Alt-Ctl-s to stop recording."

winid=`xwininfo | sed -n 's/xwininfo: Window id: \([0-9a-fx]\+\) .*/\1/p'`
recordmydesktop --overwrite --delay 1 -windowid $winid --fps 18 --no-sound -o "${gif}.ogv"
mplayer -ao null "${gif}.ogv" -vo jpeg:outdir="${jpgs}"
last=`ls "${jpgs}"/0*.jpg | tail -n 1`
convert -delay 10 "${jpgs}/0*.jpg" -fuzz 2% -layers Optimize -delay 300 "$last" "$gif"
rm -r ${jpgs}
