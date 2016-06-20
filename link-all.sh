#!/bin/sh
set -euo pipefail
IFS=$(printf '\n\t')

# shellcheck disable=SC2035
stow --no-folding "$@" -vt ~ */ --ignore='\.ignore\.[^/]*'

systemctl --user enable mpd.service
systemctl --user enable dropbox.service

systemctl --user start mpd.service
systemctl --user start dropbox.service
