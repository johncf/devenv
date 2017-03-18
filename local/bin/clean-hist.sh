#!/bin/bash

sed -ie '/^: [0-9]*:[0-9];l[sl]$/d' ~/.cache/zsh/history
sed -ie '/^: [0-9]*:[0-9];\(tm\|top\|python\)$/d' ~/.cache/zsh/history
sed -ie '/^: [0-9]*:[0-9];git \(l\|d\|ds\|pf\|push\)$/d' ~/.cache/zsh/history
sed -ie '/^: [0-9]*:[0-9];connect.sh$/d' ~/.cache/zsh/history
sed -ie '/^: [0-9]*:[0-9];hotswitch.sh$/d' ~/.cache/zsh/history
sed -ie '/^: [0-9]*:[0-9];clean-hist.sh$/d' ~/.cache/zsh/history
