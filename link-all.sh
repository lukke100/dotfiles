#!/usr/bin/env sh
set -euo pipefail
IFS=$(printf '\n\t')

SCRIPT_SRC=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_SRC")

cd "$SCRIPT_DIR"

unset SCRIPT_SRC
unset SCRIPT_DIR

# shellcheck disable=SC2035
stow --no-folding "$@" -vt ~ */ --ignore='\.ignore\.[^/]*'

XMONAD_DIR=~/.xmonad
XMONAD_SRC=$XMONAD_DIR/xmonad.hs

if [ -f "$XMONAD_SRC" ] && [ -r "$XMONAD_SRC" ]
then
  (set -x; stack ghc -- "$XMONAD_SRC" -o "$XMONAD_DIR/xmonad-x86_64-linux")
fi

unset XMONAD_DIR
unset XMONAD_SRC

systemctl --user enable mpd.service
systemctl --user enable dropbox.service

systemctl --user start mpd.service
systemctl --user start dropbox.service
