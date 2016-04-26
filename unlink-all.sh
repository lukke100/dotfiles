#!/bin/sh
set -euo pipefail
IFS="\n\t"

stow "$@" -Dvt ~ */
find ~/ -empty -type d -exec rmdir -p {} 2> /dev/null +
