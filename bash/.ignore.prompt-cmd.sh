#!/bin/sh

PROMPT_TRAIL=/
[ "$PWD" != "/" ] || PROMPT_TRAIL=
HEADER_TEXT=$(PUT_HEADER)

if [ -n "$HEADER_TEXT" ]
then
  PS1="$HEADER_TEXT\n\w$PROMPT_TRAIL λ -> "
else
  PS1="\w$PROMPT_TRAIL λ -> "
fi

PUT_TITLE

PROMPT_TRAIL=
HEADER_TEXT=
