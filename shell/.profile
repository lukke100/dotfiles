#!/bin/sh
umask 077

export BROWSER=firefox
export EDITOR=vi
export ENV=$HOME/.shrc
export PAGER=less

if [ -x /usr/bin/fortune ]
then
	/usr/bin/fortune freebsd-tips
fi
