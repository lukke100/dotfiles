#!/bin/sh
# shellcheck disable=SC2139

if [ -z "$PS1" ]
then
  return
fi

export COLORFGBG
export GREP_COLORS
export HISTFILE
export HISTFILESIZE
export HISTSIZE
export LESS
export LESS_TERMCAP_mb
export LESS_TERMCAP_md
export LESS_TERMCAP_me
export LESS_TERMCAP_se
export LESS_TERMCAP_so
export LESS_TERMCAP_ue
export LESS_TERMCAP_us
export LESSHISTFILE
export PROMPT_COMMAND
export PS2
export PS3
export PS4

if [ -n "$BASH" ]
then
  # shellcheck disable=SC2039
  shopt -s histappend

  # shellcheck disable=SC2039
  SOURCE_DIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")
else
  # TODO: determine SOURCE_DIR in a POSIX-compliant way
  SOURCE_DIR=''
fi

COLORFGBG='default;default'
GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
HISTFILE=$HOME/.cmd_history
LESS_TERMCAP_mb=$(printf '\033[01;31m')
LESS_TERMCAP_md=$(printf '\033[01;31m')
LESS_TERMCAP_me=$(printf '\033[0m')
LESS_TERMCAP_se=$(printf '\033[0m')
LESS_TERMCAP_so=$(printf '\033[01;44;33m')
LESS_TERMCAP_ue=$(printf '\033[0m')
LESS_TERMCAP_us=$(printf '\033[01;32m')
LESS='-FRXis'
LESSHISTFILE=/dev/null
PROMPT_COMMAND=$(cat "$SOURCE_DIR/.ignore.prompt-cmd.sh")
PS2='... '
PS3='> '
PS4='+ '

HISTFILESIZE=""
HISTSIZE=""

COLORTYPE='--color=auto'
DIRSFIRST='--group-directories-first'
TIMESTYLE='--time-style=long-iso'

alias dir="dir $COLORTYPE $DIRSFIRST $TIMESTYLE"
alias grep="grep $COLORTYPE"
alias info="info --vi-keys"
alias la="ls -A"
alias ll="ls -l"
alias ls="ls -1HLbh --file-type $COLORTYPE $DIRSFIRST $TIMESTYLE"
alias top=htop
alias vdir="vdir -A $COLORTYPE $DIRSFIRST $TIMESTYLE"

unset COLORTYPE
unset DIRSFIRST
unset TIMESTYLE

RM_EX_RGX='s/ex\=[0-9][0-9];[0-9][0-9]:/ex\=0:/'
eval "$(dircolors -b | sed -e "$RM_EX_RGX")"
unset RM_EX_RGX

BASH_COMPLETE=/usr/share/bash-completion/bash_completion
GIT_COMPLETE=/usr/share/git/completion/git-prompt.sh

if [ -r "$BASH_COMPLETE" ]
then
  # shellcheck disable=SC1090
  . "$BASH_COMPLETE"
fi

if [ -r "$GIT_COMPLETE" ]
then
  # shellcheck disable=SC1090
  . "$GIT_COMPLETE"
fi

unset BASH_COMPLETE
unset GIT_COMPLETE

if echo "$TERM" | grep -q linux
then
  USE_BACKGROUND=false

  printf '\033]P1ff6565' # Red
  printf '\033]P293d44f' # Green
  printf '\033]P3eab93d' # Yellow
  printf '\033]P4204a87' # Blue
  printf '\033]P5ce5c00' # Magenta
  printf '\033]P689b6e2' # Cyan
  printf '\033]P7cccccc' # White
  printf '\033]P8555753' # Bright Black
  printf '\033]P9ff8d8d' # Bright Red
  printf '\033]PAc8e7a8' # Bright Green
  printf '\033]PBffc123' # Bright Yellow
  printf '\033]PC3465a4' # Bright Blue
  printf '\033]PDf57900' # Bright Magenta
  printf '\033]PE46a4ff' # Bright Cyan
  printf '\033]PFffffff' # Bright White

  # changing background color doesn't fully apply unless `clear` is called
  if "$USE_BACKGROUND"
  then
    printf '\033]P0000000' # Black
    clear
  fi

  unset USE_BACKGROUND
fi
