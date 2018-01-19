#!/usr/bin/env sh
set -eu
IFS=$(printf '\n\t')

SCRIPT_SRC=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_SRC")

cd "$SCRIPT_DIR"

# shellcheck disable=SC2035
stow --no-folding "$@" -vt ~ */ --ignore='\.ignore\.[^/]*'
