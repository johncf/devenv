# Originals:
# https://github.com/spicycode/ze-best-zsh-config/blob/master/.zsh/completion.zsh
# https://github.com/mattjj/my-oh-my-zsh/blob/master/completion.zsh

# add in zsh-completions
autoload -U compinit && compinit -d ~/.cache/zsh/compdump
zmodload -i zsh/complist

# Enable completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.cache/zsh/$HOST

# Fallback to built in ls colors
zstyle ':completion:*' list-colors ''

# Friendly list prompt
zstyle ':completion:*' list-prompt '%SAt %p: Hit Tab/Space/Enter for more%s'

# Friendly selection prompt
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Group matches and describe.
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Array completion element sorting
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Don't complete unavailable commands
zstyle ':completion:*:functions' ignored-patterns '_*'

# include hosts from .ssh/config
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//,/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns \
	avahi systemd-journal-remote bin mail systemd-journal-upload colord \
	nobody systemd-network daemon polkitd systemd-resolve dbus \
	systemd-timesync dnsmasq rtkit transmission ftp smtpd usbmux git \
	smtpq uuidd systemd-bus-proxy http systemd-journal-gateway '_*'

# ... unless we really want to.
zstyle '*' single-ignored show
