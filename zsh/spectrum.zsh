# original: https://github.com/anishathalye/dotfiles/blob/master/zsh/plugins/spectrum.zsh
# original's origin: http://github.com/sykora/etc/blob/master/zsh/functions/spectrum
# A script to make using 256 colors in zsh less painful.
# P.C. Shyamshankar <sykora@lucentbeing.com>

typeset -Ag FX FG BG

FX=(
    reset     "%{\e[00m%}"
    bold      "%{\e[01m%}" no-bold      "%{\e[22m%}"
    italic    "%{\e[03m%}" no-italic    "%{\e[23m%}"
    underline "%{\e[04m%}" no-underline "%{\e[24m%}"
    blink     "%{\e[05m%}" no-blink     "%{\e[25m%}"
    reverse   "%{\e[07m%}" no-reverse   "%{\e[27m%}"
)

for color in {000..255}; do
    FG[$color]="%{\e[38;5;${color}m%}"
    BG[$color]="%{\e[48;5;${color}m%}"
done

# Show all 256 colors with color number
function spectrum() {
    local cols=4
    if [[ "${1}" != "" ]]; then
        cols=${1}
    fi
    local ctr=1
    for code in {000..255}; do
        print -P -n -- "$code: %F{$code}Test%f"
        if [[ "$(expr ${ctr} % ${cols})" == "0" ]]; then
            print # newline
        else
            print -n -- " " # gap
        fi
        ctr=$(expr ${ctr} + 1)
    done
    print # newline
}

