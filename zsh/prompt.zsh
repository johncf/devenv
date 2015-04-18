# original: https://github.com/anishathalye/dotfiles/blob/master/zsh/prompt.zsh

# User customizable options
PR_ARROW_CHAR="%#" # The arrow symbol that is used in the prompt
PR_SHOW_USER=true # (true, false) - show username in rhs prompt
PR_SHOW_HOST=true # (true, false) - show host in rhs prompt
PR_SHOW_GIT=true # (true, false) - show git status in rhs prompt

# Current directory
function PR_DIR() {
    local relfull="$(print -P "%~")"
    local head="$(print -P "%1~")"
    local tail="${relfull%$head}"

    echo "%{$fg[yellow]%}${tail}%{$FG[011]%}${head}%{$reset_color%}"
}

# An exclamation point if the previous command did not complete successfully
function PR_ERROR() {
    echo "%(?..%(!.%{$fg[violet]%}.%{$fg[red]%})%B!%b%{$reset_color%} )"
}

# The arrow in red (for root) or violet (for regular user)
function PR_LINE2() {
    echo "%{$FG[003]%}%t %(!.%{$fg[red]%}.%{$FG[245]%})${PR_ARROW_CHAR}%{$reset_color%}"
}

# Set custom rhs prompt
function PR_USER() {
    if [[ "${PR_SHOW_USER}" == "true" ]]; then
        echo "%(!.%{$fg_bold[red]%}.%{$fg[teal]%})%n%{$reset_color%}"
    fi
}

# Host in yellow
function PR_HOST() {
    if [[ "${PR_SHOW_HOST}" == "true" ]]; then
        echo "%{$FG[039]%}%m%{$reset_color%}"
    fi
}

# ': ' only if either user or host enabled
function PR_COLON() {
    if [[ "${PR_SHOW_USER}" == "true" ]] || [[ "${PR_SHOW_HOST}" == "true" ]]; then
        echo "%{$reset_color%}: "
    fi
}

# '@' only if both user and host enabled
function PR_AT() {
    if [[ "${PR_SHOW_USER}" == "true" ]] && [[ "${PR_SHOW_HOST}" == "true" ]]; then
        echo "%{$reset_color%}@"
    fi
}

# Build the rhs prompt
function PR_INFO() {
	echo "$(PR_USER)$(PR_AT)$(PR_HOST)$(PR_COLON)$(PR_DIR)"
}

# Set RHS prompt for git repositories
DIFF_SYMBOL="-"
GIT_PROMPT_SYMBOL=""
GIT_PROMPT_PREFIX="%{$fg[violet]%}%B(%b%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[violet]%}%B)%b%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[teal]%}%B+NUM%b%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[orange]%}%B-NUM%b%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg[cyan]%}%Bx%b%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg[red]%}%B$DIFF_SYMBOL%b%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg[yellow]%}%B$DIFF_SYMBOL%b%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg[green]%}%B$DIFF_SYMBOL%b%{$reset_color%}"
GIT_PROMPT_DETACHED="%{$fg[neon]%}%B!%b%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
function parse_git_branch() {
    (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

function parse_git_detached() {
    if ! git symbolic-ref HEAD >/dev/null 2>&1; then
        echo "${GIT_PROMPT_DETACHED}"
    fi
}

# Show different symbols as appropriate for various Git repository states
function parse_git_state() {
    # Compose this value via multiple conditional appends.
    local GIT_STATE=""

    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
    GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
    fi

    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
        if [[ -n $GIT_STATE ]]; then
            GIT_STATE="$GIT_STATE "
        fi
    GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
    fi

    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
        if [[ -n $GIT_STATE ]]; then
            GIT_STATE="$GIT_STATE "
        fi
    GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
    fi

    if [[ -n $(git ls-files --other --exclude-standard :/ 2> /dev/null) ]]; then
    GIT_DIFF=$GIT_PROMPT_UNTRACKED
    fi

    if ! git diff --quiet 2> /dev/null; then
    GIT_DIFF=$GIT_DIFF$GIT_PROMPT_MODIFIED
    fi

    if ! git diff --cached --quiet 2> /dev/null; then
    GIT_DIFF=$GIT_DIFF$GIT_PROMPT_STAGED
    fi

    if [[ -n $GIT_STATE && -n $GIT_DIFF ]]; then
        GIT_STATE="$GIT_STATE "
    fi
    GIT_STATE="$GIT_STATE$GIT_DIFF"

    if [[ -n $GIT_STATE ]]; then
    echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
    fi
}

# If inside a Git repository, print its branch and state
function git_prompt_string() {
    if [[ "${PR_SHOW_GIT}" == "true" ]]; then
        local git_where="$(parse_git_branch)"
        local git_detached="$(parse_git_detached)"
        [ -n "$git_where" ] && echo " $GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$FG[209]%}%B${git_where#(refs/heads/|tags/)}%b$git_detached$GIT_PROMPT_SUFFIX"
    fi
}

PROMPT_MODE=0

# Function to toggle between prompt modes
function prompt_mode_toggle() {
    if [[ "${PROMPT_MODE}" == 0 ]]; then
        PROMPT_MODE=1
		PROMPT='$(PCMD)'
    else
        PROMPT_MODE=0
    fi
}

# Prompt
function PCMD() {
    if [[ "${PROMPT_MODE}" == 0 ]]; then
        echo "$(PR_INFO)"$'\n'"$(PR_LINE2) "
    else
        echo "%n@%m: %~"$'\n'"%t ${PR_ARROW_CHAR} "
    fi
}

PROMPT='$(PCMD)' # single quotes to prevent immediate execution
RPROMPT='$(PR_ERROR)' # set asynchronously and dynamically

function ACMD() {
	echo '$(PR_INFO)'"$(git_prompt_string)"$'\n'"$(PR_LINE2) "
}

ASYNC_PROC=0
function precmd() {
    function async() {
        # save to temp file
        printf "%s" "$(ACMD)" > "/tmp/${USER}_zsh_prompt"

        # signal parent
        kill -s USR1 $$
    }

    # kill child if necessary
    if [[ "${ASYNC_PROC}" != 0 ]]; then
        kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || :
    fi

    # start background computation
    if [[ "${PROMPT_MODE}" == 0 ]]; then
		async &!
		ASYNC_PROC=$!
	fi
}

function TRAPUSR1() {
    # read from temp file
    local pr_tmp="$(cat /tmp/${USER}_zsh_prompt)"

    # reset proc number
    ASYNC_PROC=0

    # redisplay
	if [[ "$pr_tmp" != "$PROMPT" ]]; then
		PROMPT="$pr_tmp"
		zle && zle reset-prompt
	fi
}

