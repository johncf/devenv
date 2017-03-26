# original: https://github.com/anishathalye/dotfiles/blob/master/zsh/prompt.zsh

# User customizable options
PR_ARROW_CHAR="%#" # The arrow symbol that is used in the prompt
LIGHT_MODE="false" # lightweight mode with alt colors (no git)
if [[ "$EUID" == 0 ]]; then
    LIGHT_MODE="true"
fi

# Current directory
function PR_DIR() {
    local relfull="$(print -P "%~")"
    local head="$(print -P "%1~")"
    local tail="${relfull%$head}"

    echo "%{$fg[darkyellow]%}${tail}%{$fg[yellow]%}${head}%{$reset_color%}"
}

# An exclamation point if the previous command did not complete successfully
function PR_ERROR() {
    echo "%(?..%{$fg[red]%}%B!%b%{$reset_color%} )"
}

# Time and arrow
function PR_LINE2() {
    echo "%{$fg[orange]%}%D{%H:%M} %{$fg[grey]%}${PR_ARROW_CHAR}%{$reset_color%}"
}

function PR_HOST() {
    if [ -z "$SSH_CLIENT" ]; then
        echo "%{$fg[cyan]%}%m%{$reset_color%}"
    else
        echo "%{$fg[grey]%}%m%{$reset_color%}"
    fi
}

function PR_INFO() {
    local PR_USER="%{$fg[teal]%}%n%{$reset_color%}"
    echo "${PR_USER}@$(PR_HOST): $(PR_DIR)"
}

# The static prompt
function PCMD() {
    if [[ "${LIGHT_MODE}" == "false" ]]; then
        echo "$(PR_INFO)"$'\n'"$(PR_LINE2) "
    else
        local PR_USER="%{$fg[alt_user]%}%n%{$reset_color%}"
        local PR_DIR="%{$fg[alt_path]%}%~%{$reset_color%}"
        local PR_LINE2="%{$fg[alt_time]%}%D{%H:%M} %{$fg[alt_red]%}${PR_ARROW_CHAR}%{$reset_color%} "
        echo "${PR_USER}@$(PR_HOST): ${PR_DIR}"$'\n'"${PR_LINE2}"
    fi
}

PROMPT='$(PCMD)' # single quotes to prevent immediate execution
RPROMPT='$(PR_ERROR)' # set asynchronously and dynamically

# git stuff {{{
DIFF_SYMBOL="-"
GIT_PROMPT_SYMBOL=""
GIT_PROMPT_PREFIX="%{$fg[violet]%}%B(%b%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[violet]%}%B)%b%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[teal]%}%B+NUM%b%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[brown]%}%B-NUM%b%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg[cyan]%}%Bx%b%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg[red]%}%B$DIFF_SYMBOL%b%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg[darkyellow]%}%B$DIFF_SYMBOL%b%{$reset_color%}"
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
    local git_where="$(parse_git_branch)"
    local git_detached="$(parse_git_detached)"
    [ -n "$git_where" ] && echo " $GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[lightred]%}%B${git_where#(refs/heads/|tags/)}%b$git_detached$GIT_PROMPT_SUFFIX"
}
# git }}}

# The async prompt
function ACMD() {
    echo '$(PR_INFO)'"$(git_prompt_string)"$'\n'"$(PR_LINE2) "
}

ASYNC_PROC=0
function precmd() {
    if [[ "${LIGHT_MODE}" != "false" ]]; then
        return
    fi

    function async() {
        # save to temp file
        printf "%s" "$(ACMD)" > "/tmp/${USER}_zsh_prompt"

        # signal parent
        kill -s USR1 $$
    }

    # kill child if necessary
    if [[ "${ASYNC_PROC}" != 0 ]]; then
        kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || true
    fi

    # start background computation
    async &!
    ASYNC_PROC=$!
}

function TRAPUSR1() {
    # read from temp file
    local PREV_PROMPT="$PROMPT"
    PROMPT="$(cat /tmp/${USER}_zsh_prompt)"

    # reset proc number
    ASYNC_PROC=0

    # redisplay
    [[ "$PROMPT" != "$PREV_PROMPT" ]] && zle && zle reset-prompt
}

