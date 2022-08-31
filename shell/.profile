#!/bin/sh
umask 077

export BROWSER=firefox
export EDITOR=vi
export ENV=$HOME/.shrc
export LESS=-Rcis
export LESSHISTFILE=/dev/null
export MANWIDTH=72
export PAGER=less
export PATH=$HOME/.local/bin:$HOME/perl5/bin:$PATH
export PERL5LIB=$HOME/perl5/lib/perl5${PERL5LIB:+:$PERL5LIB}
export PERL_LOCAL_LIB_ROOT=$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:$PERL_LOCAL_LIB_ROOT}
export PERL_MB_OPT="--install_base $HOME/perl5"
export PERL_MM_OPT=INSTALL_BASE=$HOME/perl5

mkdir -p "$HOME/.local/bin"

if [ "${BASH+ }" ]
then
	. "$ENV"
fi

if [ -x /usr/bin/fortune -a -z "${TMUX+ }" ]
then
	/usr/bin/fortune freebsd-tips
fi
