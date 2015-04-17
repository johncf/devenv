# part of: https://github.com/anishathalye/dotfiles/blob/master/zsh/prompt.zsh

# Load color variables to make it easier to color things
autoload -U colors && colors

# Make using 256 colors easier
if [[ "$(tput colors)" == "256" ]]; then
    source ~/.zsh/spectrum.zsh
    # change default colors
    fg[green]=$FG[064]
    fg[cyan]=$FG[037]
    fg[blue]=$FG[033]
    fg[teal]=$FG[041]
    fg[red]=$FG[160]
    fg[orange]=$FG[166]
    fg[yellow]=$FG[136]
    fg[magenta]=$FG[125]
    fg[violet]=$FG[061]
    fg[brown]=$FG[094]
    fg[neon]=$FG[112]
    fg[pink]=$FG[183]
    fg[darkred]=$FG[088]
else
    fg[teal]=$fg[blue]
    fg[orange]=$fg[yellow]
    fg[violet]=$fg[magenta]
    fg[brown]=$fg[orange]
    fg[neon]=$fg[green]
    fg[pink]=$fg[magenta]
    fg[darkred]=$fg[red]
fi
