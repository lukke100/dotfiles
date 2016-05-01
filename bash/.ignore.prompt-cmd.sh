#!/bin/sh

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

if [ -n "$HEADER_TEXT" ]
then
  PS1="$HEADER_TEXT\n\w$PROMPT_TRAIL λ -> "
else
  PS1="\w$PROMPT_TRAIL λ -> "
fi

PUT_TITLE

unset PROMPT_TRAIL
unset HEADER_TEXT
