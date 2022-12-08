#!/bin/sh
umask 077

export BROWSER=firefox
export EDITOR=vi
export ENV=$HOME/.shrc
export LC_CTYPE=en_US.UTF-8
export LESS=-Rcis
export LESSHISTFILE=/dev/null
export MANWIDTH=72
export PAGER=less
export PATH=$HOME/.local/bin:$HOME/perl5/bin:$PATH:/usr/games
export PERL5LIB=$HOME/perl5/lib/perl5${PERL5LIB:+:$PERL5LIB}
export PERL_LOCAL_LIB_ROOT=$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:$PERL_LOCAL_LIB_ROOT}
export PERL_MB_OPT="--install_base $HOME/perl5"
export PERL_MM_OPT=INSTALL_BASE=$HOME/perl5

mkdir -p "$HOME/.local/bin"

if [ "${BASH:+dummy}" ]
then
	. "$ENV"
fi

if [ ! -S "$HOME/.ssh/ssh-auth-sock" ]
then
	eval `ssh-agent -s`
	ln -fs "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh-auth-sock"
fi

export SSH_AUTH_SOCK=$HOME/.ssh/ssh-auth-sock

if [ -x /usr/bin/fortune ]
then
	/usr/bin/fortune freebsd-tips
elif [ -x /usr/games/fortune ]
then
	/usr/games/fortune
fi
