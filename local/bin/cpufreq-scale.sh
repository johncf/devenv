#!/bin/bash
if [ -n "$1" ]; then
    f=$(awk "BEGIN{ print ${1}*1e6 }")
    echo $f | sudo tee /sys/devices/system/cpu/cpu[0-9]/cpufreq/scaling_max_freq
else
    grep ^ /sys/devices/system/cpu/cpu[0-9]/cpufreq/scaling_cur_freq | \
        awk -F':|/' '{print $6, $9}'
fi
