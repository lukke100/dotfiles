#!/usr/bin/env sh
set -euo pipefail
IFS=$(printf '\n\t')

export DOTFILE_ROOT
export SCRIPTS_DIR
export INPUT_SCHEMA
export STYLESHEET
export TEMPLATE_DIR

DOTFILE_ROOT=$(readlink -m ./)
SCRIPTS_DIR=$(readlink -m "$DOTFILE_ROOT/.scripts/")
INPUT_SCHEMA=$(readlink -m "$SCRIPTS_DIR/templates.xsd")
STYLESHEET=$(readlink -m "$SCRIPTS_DIR/generate-configs.xslt")
TEMPLATE_DIR=$(readlink -m "$DOTFILE_ROOT/.templates/")

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
    OUTPUT_DIR=$(dirname "$(readlink -m "$DOTFILE_ROOT/.disabled/$1")")
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

  unset INPUT_FILE

  unset OUTPUT_DIR
  unset OUTPUT_NAME
  unset OUTPUT_FILE

  unset XSLT_OUTPUT
}
export -f GENERATE_CONFIG

cd "$TEMPLATE_DIR"

find ./ -type f -print0 | xargs -0n1 sh -c 'GENERATE_CONFIG "$@"' "$0"

cd "$DOTFILE_ROOT"

unset GENERATE_CONFIG

unset DOTFILE_ROOT
unset SCRIPTS_DIR
unset INPUT_SCHEMA
unset STYLESHEET
unset TEMPLATE_DIR
