#!/bin/bash
echo 1600000|sudo tee /sys/devices/system/cpu/cpu[0123]/cpufreq/scaling_max_freq
