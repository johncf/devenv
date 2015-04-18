# original: https://github.com/spicycode/ze-best-zsh-config/blob/master/.zsh/setopt.zsh

# ===== Basics

# Avoid typing 'cd'
setopt AUTO_CD

# Allow comments in interactive shells
setopt INTERACTIVE_COMMENTS

# ===== History

# Allow multiple terminal sessions to all append to one zsh command history
setopt APPEND_HISTORY

# Add comamnds as they are typed, don't wait until shell exit
setopt INC_APPEND_HISTORY

# Do not write events to history that are duplicates of previous events
setopt HIST_IGNORE_DUPS

# When searching history don't display results already cycled through twice
setopt HIST_FIND_NO_DUPS

# Ignore commands starting with a space
setopt HIST_IGNORE_SPACE

# Trim blanks off commands
setopt HIST_REDUCE_BLANKS

# Include more information about when the command was executed, etc
setopt EXTENDED_HISTORY

# ===== Completion

# Allow completion from within a word/phrase
setopt COMPLETE_IN_WORD

# When completing from the middle of a word, move the cursor to the end of the word
setopt ALWAYS_TO_END

# ===== Prompt

# Allow variable/function substitution in prompt
setopt PROMPT_SUBST


unsetopt MENU_COMPLETE
setopt AUTO_MENU
