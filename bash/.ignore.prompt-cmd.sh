PROMPT_TRAIL="/"
[[ $PWD != "/" ]] || PROMPT_TRAIL=;
PS1="$(PUT_HEADER)\n"$'\E[48;5;15;38;5;0m'"\w$PROMPT_TRAIL  λ "$'\E[0;38;5;15m\uE0B0\E[0m ';
PUT_TITLE;
