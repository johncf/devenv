# original: https://github.com/spicycode/ze-best-zsh-config/blob/master/.zsh/setopt.zsh

# ===== Basics

setopt AUTO_CD              # Avoid typing 'cd'
setopt INTERACTIVE_COMMENTS # Allow comments in interactive shells

# ===== History

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY # Append history without waiting until shell exit
setopt HIST_IGNORE_DUPS   # Check if duplicate of the previous command
setopt HIST_FIND_NO_DUPS  # While searching history, avoid showing duplicates
setopt HIST_IGNORE_SPACE  # Ignore commands starting with a space
setopt HIST_REDUCE_BLANKS # Trim blanks off commands
setopt EXTENDED_HISTORY   # More information in history (timestamp etc.)

# ===== Completion

setopt COMPLETE_IN_WORD # Complete from both ends of a word
setopt ALWAYS_TO_END    # Move cursor to the end of a completed word
setopt AUTO_MENU        # Show completion menu on a succesive tab press
setopt AUTO_LIST        # Automatically list choices on ambiguous completion
unsetopt MENU_COMPLETE  # Do not autoselect the first completion entry

# ===== Prompt

setopt PROMPT_SUBST # Allow variable/function substitution in prompt

