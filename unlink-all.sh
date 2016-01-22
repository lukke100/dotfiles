#!/bin/bash
stow $@ -Dvt ~ */
find ~/ -empty -type d -exec rmdir -p {} 2> /dev/null +
