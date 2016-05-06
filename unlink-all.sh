#!/bin/sh
set -euo pipefail
IFS=$(printf '\n\t')

# shellcheck disable=SC2035
stow "$@" -Dvt ~ */
find ~/ -empty -type d -exec rmdir -p {} 2> /dev/null +
