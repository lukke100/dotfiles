#!/usr/bin/env sh
set -euo pipefail
IFS=$(printf '\n\t')

SCRIPT_SRC=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_SRC")

cd "$SCRIPT_DIR"

# shellcheck disable=SC2035
stow --no-folding "$@" -vt ~ */ --ignore='\.ignore\.[^/]*'

systemctl --user enable mpd.service
systemctl --user enable dropbox.service

systemctl --user start mpd.service
systemctl --user start dropbox.service
