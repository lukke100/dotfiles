#!/bin/sh
umask 077

export ASAN_OPTIONS=abort_on_error=1:disable_coredump=0:unmap_shadow_on_exit=1
export BROWSER=firefox
export EDITOR=vi
export ENV="$HOME/.shrc"
export HISTFILE="$HOME/.history"
export HISTSIZE=1000
export LC_CTYPE=en_US.UTF-8
export LESS=-Rcis
export LESSHISTFILE=/dev/null
export MANWIDTH=72
export PAGER=less
export PATH="$HOME/.local/bin:$HOME/perl5/bin:$PATH:/usr/games"
export PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:$PERL5LIB}"
export PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:$PERL_LOCAL_LIB_ROOT}"
export PERL_MB_OPT="--install_base $HOME/perl5"
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"
export PS1='$USER${HOSTNAME+@$HOSTNAME}:\w \$ '

mkdir -p "$HOME/.local/bin"

if [ ! -S "$HOME/.ssh/ssh_auth_sock" ]
then
	if [ -z "$SSH_AUTH_SOCK" ]
	then
		eval "$(ssh-agent -s)"
	fi

	ln -sf "$SSH_AUTH_SOCK" "$HOME/.ssh/ssh_auth_sock"
fi

export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"

if [ -x /usr/bin/fortune ]
then
	/usr/bin/fortune freebsd-tips
elif [ -x /usr/games/fortune ]
then
	/usr/games/fortune
fi

if [ -x /usr/bin/lesspipe ]
then
	eval "$(SHELL=/bin/sh lesspipe)"
fi

if [ -n "$BASH" ]
then
	. "$ENV"
fi
