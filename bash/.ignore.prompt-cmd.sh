#!/usr/bin/env sh
PUT_HEADER()
{
  printf ''
}

PUT_TITLE()
{
  TITLE_PATH=$(echo "$PWD" | sed -e "s@$HOME@~@" | sed -e "s@//@/@")

  printf "\033]0;bash (%s) - urxvt\007" "$TITLE_PATH"

  unset TITLE_PATH
}

PROMPT_TRAIL=/
[ "$PWD" != / ] || unset PROMPT_TRAIL
HEADER_TEXT=$(PUT_HEADER)

if [ "$(id -u)" -eq "0" ]
then
  USER_IND='#'
else
  USER_IND='>'
fi

if [ -n "$HEADER_TEXT" ]
then
  PS1="$HEADER_TEXT\n\w$PROMPT_TRAIL $USER_IND "
else
  PS1="\w$PROMPT_TRAIL $USER_IND "
fi

PUT_TITLE

unset PROMPT_TRAIL
unset HEADER_TEXT
unset USER_IND

if [ -n "$BASH" ]
then
  history -a
fi
