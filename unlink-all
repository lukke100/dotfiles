#!/usr/bin/env sh
set -eu
IFS=$(printf '\n\t')

# shellcheck disable=SC2035
stow "$@" -Dvt ~ */
find ~/ -empty -type d -delete
