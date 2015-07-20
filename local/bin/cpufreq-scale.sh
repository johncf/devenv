#!/bin/bash
f=1600000
if [ -n "$1" ]; then
    f=$(python2 -c "print int(float($1)*1e6)")
fi
echo $f|sudo tee /sys/devices/system/cpu/cpu[0123]/cpufreq/scaling_max_freq
