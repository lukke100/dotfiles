#!/usr/bin/env sh
set -euo pipefail
IFS=$(printf '\n\t')

IGNORE_LEN=12

for IMPORT_PATH in "$@"
do
  IMPORT_FLDR=$(dirname "$IMPORT_PATH")
  IMPORT_NAME="${IMPORT_PATH##*/}"
  IMPORT_SUFX="${IMPORT_NAME##*.}"
  IMPORT_NAME="${IMPORT_NAME%.*}"
  EXPORT_NAME="$(pwgen 12 1)"

  if [ "$IMPORT_NAME" = "$IMPORT_SUFX" ]
  then
    IMPORT_SUFX=""
  else
    IMPORT_SUFX=".$IMPORT_SUFX"
  fi

  EXPORT_PATH="$IMPORT_FLDR/$EXPORT_NAME$IMPORT_SUFX"

  if [ "${#IMPORT_NAME}" -ne "$IGNORE_LEN" ]
  then
    mv --verbose "$IMPORT_PATH" "$EXPORT_PATH"
  fi
done
