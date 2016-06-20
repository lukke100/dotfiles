#!/bin/sh
set -euo pipefail
IFS=$(printf '\n\t')

# shellcheck disable=SC2035
stow "$@" -Dvt ~ */
find ~/ -empty -type d -delete

systemctl --user disable mpd.service
systemctl --user disable dropbox.service

systemctl --user stop mpd.service
systemctl --user stop dropbox.service
