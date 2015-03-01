#!/bin/bash
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\n|------------------------------------------------------------------------------|\n|\u@\h \w -> '
PS2='... '
PS3='> '
PS4='+ '

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

export COLOR_SED='sed s/ex\=[0-9][0-9];[0-9][0-9]:/ex\=0:/'
eval $(dircolors -b | $COLOR_SED)
unset COLOR_SED
alias la="ls -A"
alias ls="ls -hbHL1 --time-style=long-iso --file-type --color --group-directories-first"
alias ll="ls -l"
alias dir="dir --color --time-style=long-iso --group-directories-first"
alias vdir="vdir -A --color --time-style=long-iso --group-directories-first"
alias grep='grep --color=auto'
alias info='info --vi-keys'
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export BROWSER=firefox
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS="-RXFsi"
export LESSHISTFILE='/dev/null'
export HISTFILE="/home/lukke/.cmd_history"
export XDG_CONFIG_HOME="/home/lukke/.config"
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"
unset HISTFILESIZE
unset HISTSIZE
shopt -s histappend
alias top='htop'

# For mutt
COLORFGBG="default;default"
