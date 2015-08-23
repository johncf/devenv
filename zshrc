source ~/.zsh/setopt.zsh

source ~/.zsh/bindkeys.zsh
source ~/.zsh/colors.zsh

source ~/.zsh/env.zsh

source ~/.zsh/completion.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/prompt.zsh

source ~/.zsh/fasd/fasd
[[ -f $FASD_INIT_CACHE ]] \
    && source $FASD_INIT_CACHE \
    || echo 'fasd cache not found! Do `zsh_recompile`'
