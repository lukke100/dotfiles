#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

stow --no-folding "$@" -vt ~ */ --ignore='\.ignore\.[^/]*'
