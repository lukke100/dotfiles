#!/bin/sh
set -euo pipefail
IFS=$(printf '\n\t')

# shellcheck disable=SC2035
stow --no-folding "$@" -vt ~ */ --ignore='\.ignore\.[^/]*'
