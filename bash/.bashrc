#!/bin/bash

[[ $- != *i* ]] && return

alias ls=$(  echo ls    -1HLbh --color=auto --group-directories-first --time-style=long-iso --file-type)
alias la=$(  echo ls    -A     )
alias ll=$(  echo ls    -l     )
alias dir=$( echo dir          --color=auto --group-directories-first --time-style=long-iso )
alias vdir=$(echo vdir  -A     --color=auto --group-directories-first --time-style=long-iso )
alias grep=$(echo grep         --color=auto )
alias info=$(echo info         --vi-keys    )
alias top=$( echo htop  )

SOURCE_DIR=$(dirname $(realpath "$BASH_SOURCE"))

function PUT_HEADER
{
    SCRIPT_LOC="$SOURCE_DIR/.ignore.header-cmd.plx"
    HEADER_CHR=$(if [[ $UID != 0 ]]; then echo ' '; else echo '#'; fi)

    (type resize > /dev/null 2>&1) && (eval $(resize))

    (type screen > /dev/null 2>&1) && (screen -X title "$(pwd)" > /dev/null 2>&1)

    [[ -x "$SCRIPT_LOC" ]] && [[ -n "$COLUMNS" ]] && "$SCRIPT_LOC" \
        -title      $'\uE0B0'" $(hostname) "$'\uE0B2' \
        -width      "$COLUMNS" \
        -pad        "$HEADER_CHR" \
        -ansi_line  $'\E[48;5;15;38;5;0m' \
        -ansi_title $'\E[0;38;5;15m'
}

function PUT_TITLE
{
    TITLE_PATH="${PWD/"$HOME"/\~}/"
    TITLE_PATH="${TITLE_PATH/\/\//\/}"
    echo -ne "\033]0; bash ($TITLE_PATH) - urxvt\007"
}

PROMPT_COMMAND=$(cat "$SOURCE_DIR/.ignore.prompt-cmd.sh")

PS2='... '
PS3='> '
PS4='+ '

HISTFILE="$HOME/.cmd_history"
shopt -s histappend
unset HISTFILESIZE
unset HISTSIZE

COLORFGBG='default;default'

GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'

RM_EX_RGX='s/ex\=[0-9][0-9];[0-9][0-9]:/ex\=0:/'
eval $(dircolors -b | sed "$RM_EX_RGX")
RM_EX_RGX=

LESS='-FRXis'
LESSHISTFILE='/dev/null'
LESS_TERMCAP_mb=$'\E[01;31m'
LESS_TERMCAP_md=$'\E[01;31m'
LESS_TERMCAP_me=$'\E[0m'
LESS_TERMCAP_se=$'\E[0m'
LESS_TERMCAP_so=$'\E[01;44;33m'
LESS_TERMCAP_ue=$'\E[0m'
LESS_TERMCAP_us=$'\E[01;32m'

# GIT_PS1_SHOWDIRTYSTATE=1
# GIT_PS1_SHOWSTASHSTATE=1
# GIT_PS1_SHOWUNTRACKEDFILES=1
# GIT_PS1_SHOWCOLORHINTS=1
# GIT_PS1_DESCRIBE_STYLE='branch'
# GIT_PS1_SHOWUPSTREAM='auto git'

GIT_COMPLETE="/usr/share/git/completion/git-prompt.sh"
BASH_COMPLETE="/usr/share/bash-completion/bash_completion"

[[ -r "$GIT_COMPLETE" ]] && source "$GIT_COMPLETE"
[[ -r "$BASH_COMPLETE" ]] && source "$BASH_COMPLETE"

