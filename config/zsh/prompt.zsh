# original: https://github.com/anishathalye/dotfiles/blob/master/zsh/prompt.zsh

# User customizable options
PR_ARROW_CHAR="%#" # The arrow symbol that is used in the prompt
PR_NOGIT_MODE="false" # lightweight mode without git info
if [[ "$EUID" == 0 ]]; then
    PR_NOGIT_MODE="true"
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
        echo ""
    else
        echo "@%{$fg[grey]%}%m%{$reset_color%}"
    fi
}

function PR_VIRTENV() {
    if [ -n "$VIRTUAL_ENV" ]; then
        shortpath="$(realpath --relative-to=. "$VIRTUAL_ENV")"
        homepath="~/$(realpath --relative-to="$HOME" "$VIRTUAL_ENV" | sed 's#dev/__env/#d/_/#')"
        if [ ${#homepath} -le ${#shortpath} ]; then
            shortpath="$homepath"
        fi
        echo " (%{$fg[grey]%}${shortpath}%{$reset_color%})"
    elif [ -n "$CONDA_DEFAULT_ENV" ]; then
        echo " (%{$fg[grey]%}conda:${CONDA_DEFAULT_ENV}%{$reset_color%})"
    else
        echo ""
    fi
}

function PR_USER() {
    local COLOR="%{$fg[teal]%}"
    if [[ "$EUID" == 0 ]]; then
        local COLOR="%{$fg[alt_red]%}"
    fi
    echo "${COLOR}%n%{$reset_color%}"
}

function PR_INFO() {
    echo "$(PR_USER)$(PR_HOST)$(PR_VIRTENV): $(PR_DIR)"
}

# The static prompt
function PCMD() {
    echo "$(PR_INFO)"$'\n'"$(PR_LINE2)"
}

PROMPT='$(PCMD)' # single quotes to prevent immediate execution
RPROMPT='$(PR_ERROR)'

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
    local GIT_STATE="" GIT_DIFF=""

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

function precmd() {
    if [[ "${PR_NOGIT_MODE}" != "false" ]]; then
        return
    fi

    typeset -g _PROMPT_ASYNC_FD

    # close last fd, we don't care about the result anymore
    if [[ -n "$_PROMPT_ASYNC_FD" ]] && { true <&$_PROMPT_ASYNC_FD } 2>/dev/null; then
        exec {_PROMPT_ASYNC_FD}<&-
    fi

    # compute prompt in a background process
    exec {_PROMPT_ASYNC_FD}< <(printf "%s" "$(ACMD)")

    # when fd is readable, call response handler
    zle -F "$_PROMPT_ASYNC_FD" async_prompt_complete
}

function async_prompt_complete() {
    local PREV_PROMPT="$PROMPT"
    # read from fd
    PROMPT="$(<&$1)"

    # remove the handler and close the fd
    zle -F "$1"
    exec {1}<&-

    # redisplay if necessary
    [[ "$PROMPT" != "$PREV_PROMPT" ]] && zle && zle reset-prompt
}
