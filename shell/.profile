#!/usr/bin/env sh
umask 077

export PATH
export CLASSPATH

export BROWSER
export EDITOR
export PAGER
export VISUAL

export PERL5LIB
export PERL5OPT
export PERL_LOCAL_LIB_ROOT
export PERL_MB_OPT
export PERL_MM_OPT

# shellcheck disable=SC2016
PERL_NUB='sub nub { (@_)? ($_[0], nub(grep { $_ ne $_[0] } @_[1..$#_])) : () }'
PATH_FIX="$PERL_NUB; print(join(':', nub(map {split':'} @ARGV)))"

HOME_BIN=$HOME/.local/bin
PERL_BIN=$HOME/.perl5/bin

PATH=$(perl -e "$PATH_FIX" "$HOME_BIN" "$PERL_BIN" "$PATH")
CLASSPATH=$(perl -e "$PATH_FIX" "$CLASSPATH" "." /usr/share/java/*.jar)

BROWSER=firefox-developer
EDITOR=nvim
PAGER=less
VISUAL=nvim

PERL5LIB="$HOME/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
PERL5OPT="-I$HOME/.perl5/lib/perl5 -I$HOME/.perl5/lib/perl5/site_perl"
PERL_LOCAL_LIB_ROOT="$HOME/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
PERL_MB_OPT="--install_base \"$HOME/.perl5\""
PERL_MM_OPT="INSTALL_BASE=$HOME/.perl5"

BASHRC=$HOME/.bashrc

if [ -x "$BASHRC" ]
then
  # shellcheck disable=SC1090
  . "$BASHRC"
fi
