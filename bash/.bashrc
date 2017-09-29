#!/usr/bin/env sh
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
  shopt -s checkwinsize histappend

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

DIR_FLAGS="-HLbho --file-type $COLORTYPE $DIRSFIRST $TIMESTYLE"

alias dir="dir $DIR_FLAGS"
alias grep="grep $COLORTYPE"
alias info="info --vi-keys"
alias ls="ls $DIR_FLAGS"
alias vdir="vdir -A $DIR_FLAGS"

RM_EX_RGX='s/ex\=[0-9][0-9];[0-9][0-9]:/ex\=0:/'
eval "$(dircolors -b | sed -e "$RM_EX_RGX")"

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

if echo "$TERM" | grep -q linux
then
  USE_BACKGROUND=false

  printf '\033]P17e1741' # Red
  printf '\033]P21b511d' # Green
  printf '\033]P36d2717' # Yellow
  printf '\033]P4511da3' # Blue
  printf '\033]P56b1970' # Magenta
  printf '\033]P6443879' # Cyan
  printf '\033]P7bfbfbf' # White
  printf '\033]P87f7f7f' # Light Black
  printf '\033]P9e65e62' # Light Red
  printf '\033]PA569d1c' # Light Green
  printf '\033]PBc27a2c' # Light Yellow
  printf '\033]PC7d81db' # Light Blue
  printf '\033]PDd35aca' # Light Magenta
  printf '\033]PE66964f' # Light Cyan
  printf '\033]PFffffff' # Light White

  # changing background color doesn't fully apply unless `clear` is called
  if "$USE_BACKGROUND"
  then
    printf '\033]P0000000' # Black
    clear
  fi
fi
