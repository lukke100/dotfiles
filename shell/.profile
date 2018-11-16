#!/bin/sh
umask 077

export BROWSER=firefox
export EDITOR=vi
export ENV=$HOME/.shrc
export PAGER=less

if [ "${BASH+ }" ]
then
	. "$ENV"
fi

if [ -x /usr/bin/fortune -a -z "${TMUX+ }" ]
then
	/usr/bin/fortune freebsd-tips
fi
