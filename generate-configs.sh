#!/usr/bin/env sh
set -euo pipefail
IFS=$(printf '\n\t')

export DOTFILE_ROOT
export META_DIR
export INPUT_SCHEMA
export STYLESHEET
export TEMPLATE_DIR

DOTFILE_ROOT=$(readlink -m ./)
META_DIR=$(readlink -m "$DOTFILE_ROOT/.meta/")
TEMPLATE_DIR=$(readlink -m "$META_DIR/templates/")
INPUT_SCHEMA=$(readlink -m "$META_DIR/templates.xsd")
STYLESHEET=$(readlink -m "$META_DIR/generate-configs.xslt")

GENERATE_CONFIG()
{
  set -euo pipefail
  IFS=$(printf '\n\t')

  if [ -n "$BASH" ]
  then
    # shellcheck disable=SC2039
    trap 'exit 255' ERR
  fi

  # TODO: with POSIX-compliance, short-circuit on processing failure

  INPUT_FILE=$(readlink -m "$TEMPLATE_DIR/$1")

  OUTPUT_DIR=$(dirname "$(readlink -m "$DOTFILE_ROOT/$1")")

  if [ ! -d "$OUTPUT_DIR" ]
  then
    OUTPUT_DIR=$(dirname "$(readlink -m "$META_DIR/disabled/$1")")
  fi

  OUTPUT_NAME=$(basename -s ".xml" "$INPUT_FILE")
  OUTPUT_FILE=$OUTPUT_DIR/$OUTPUT_NAME

  XSLT_OUTPUT=$(mktemp)

  xmllint --noout --schema "$INPUT_SCHEMA" --xinclude "$INPUT_FILE"

  xsltproc --output "$XSLT_OUTPUT" --xinclude "$STYLESHEET" "$INPUT_FILE"

  sed -i --posix 's/ *$//g' "$XSLT_OUTPUT" # delete trailing whitespace
  sed -i --posix '/./,$!d'  "$XSLT_OUTPUT" # delete leading newlines

  # delete trailing newlines and write to file
  tac "$XSLT_OUTPUT" | sed --posix '/./,$!d' | tac - > "$OUTPUT_FILE"

  rm "$XSLT_OUTPUT"
}
export -f GENERATE_CONFIG

cd "$TEMPLATE_DIR"

find ./ -type f -print0 | xargs -0n1 sh -c 'GENERATE_CONFIG "$@"' "$0"

cd "$DOTFILE_ROOT"
