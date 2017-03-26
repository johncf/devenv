source ~/.config/zsh/setopt.zsh

source ~/.config/zsh/bindkeys.zsh
source ~/.config/zsh/colors.zsh

source ~/.config/zsh/env.zsh

source ~/.config/zsh/completion.zsh
source ~/.config/zsh/functions.zsh
source ~/.config/zsh/prompt.zsh

source ~/.config/zsh/fasd/fasd
[[ -f $FASD_INIT_CACHE ]] \
    && source $FASD_INIT_CACHE \
    || echo 'fasd cache not found! Do `zsh_recompile`'

# machine specific settings
source ~/.config/machine
