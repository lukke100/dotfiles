#!/bin/sh

umask 077

PERL_NUB='sub nub { (@_)? ($_[0], nub(grep { $_ ne $_[0] } @_[1..$#_])) : () }'
PATH_FIX="$PERL_NUB; print(join(':', nub(map {split':'} @ARGV)))"

HOME_BIN=$HOME/.local/bin
PERL_BIN=$HOME/perl5/bin
CLUA_BIN=$(luarocks path --lr-bin)
RUBY_BIN=$(ruby -rubygems -e "puts Gem.user_dir")/bin
HASK_BIN=$(stack path | grep "^bin-path: " | sed "s/^bin-path: //")

export PATH=$(perl -e "$PATH_FIX" "$HOME_BIN" "$HASK_BIN" "$PERL_BIN" "$RUBY_BIN" "$CLUA_BIN" "$PATH")

export BROWSER=firefox
export EDITOR=vim
export VISUAL=vim
export PAGER=less
export XDG_CONFIG_HOME=$HOME/.config

export LUA_PATH=$(luarocks path --lr-path)
export LUA_CPATH=$(luarocks path --lr-cpath)

export PERL5LIB=$(perl -e "$PATH_FIX" "$HOME/perl5/lib/perl5" "$PERL5LIB")
export PERL_LOCAL_LIB_ROOT=$(perl -e "$PATH_FIX" "$HOME/perl5" "$PERL_LOCAL_LIB_ROOT")
export PERL_MB_OPT="--install_base '$HOME/perl5'"
export PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"

if [ ! $(pidof transmission-daemon) ];
then
    transmission-daemon &
fi
