# part of: https://github.com/anishathalye/dotfiles/blob/master/zsh/prompt.zsh

# Load color variables to make it easier to color things
autoload -U colors && colors

# Make using 256 colors easier
if [[ "$(tput colors)" == "256" ]]; then
    source ~/.config/zsh/spectrum.zsh
    # change default colors
    fg[green]=$FG[064]
    fg[cyan]=$FG[038]
    fg[blue]=$FG[033]
    fg[teal]=$FG[041]
    fg[red]=$FG[160]
    fg[orange]=$FG[003]
    fg[yellow]=$FG[011]
    fg[magenta]=$FG[125]
    fg[violet]=$FG[061]
    fg[brown]=$FG[130]
    fg[neon]=$FG[112]
    fg[pink]=$FG[183]
    fg[lightred]=$FG[209]
    fg[darkred]=$FG[088]
    fg[grey]=$FG[245]
    fg[darkyellow]=$FG[136]

    fg[alt_user]=$FG[203]
    fg[alt_path]=$FG[071]
    fg[alt_time]=$FG[185]
    fg[alt_red]=$FG[009]
else
    fg[teal]=$fg[green]
    fg[orange]=$fg[yellow]
    fg[violet]=$fg[magenta]
    fg[brown]=$fg[orange]
    fg[neon]=$fg[green]
    fg[pink]=$fg[magenta]
    fg[lightred]=$fg_bold[red]
    fg[darkred]=$fg[red]
    fg[grey]=$fg_bold[grey]
    fg[darkyellow]=$fg[default]
    fg[yellow]=$fg_bold[yellow]

    fg[alt_user]=$fg[lightred]
    fg[alt_path]=$fg[green]
    fg[alt_time]=$fg[grey]
    fg[alt_red]=$fg[lightred]
fi
