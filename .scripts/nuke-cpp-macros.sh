#!/bin/sh
set -euo pipefail
IFS=$(printf '\n\t')

for INPUT_FILE in "$@"
do
  TMP_FILE=$(mktemp)

  cpp -E "$INPUT_FILE" -o "$TMP_FILE" -traditional-cpp
  sed -i 's/^ *#.*//' "$TMP_FILE"
  cat -s "$TMP_FILE" > "$INPUT_FILE"

  rm "$TMP_FILE"
  unset TMP_FILE
done
