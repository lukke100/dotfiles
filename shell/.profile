#!/bin/sh

umask 077

export PATH

export BROWSER
export EDITOR
export EMSCRIPTEN_ROOT
export GOPATH
export LLVM_ROOT
export LUA_CPATH
export LUA_PATH
export NODE_JS
export PAGER
export VISUAL
export XDG_CONFIG_HOME

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
CLUA_BIN=$(luarocks path --lr-bin)
RUBY_BIN=$(ruby -rubygems -e "puts Gem.user_dir")/bin
GO_L_BIN=$HOME/.go/bin

# TODO: replace `type` with POSIX compliant function
HASK_BIN=$( ( (type stack > /dev/null 2>&1) && (stack path 2> /dev/null) ) | \
  grep "^bin-path: " | sed "s/^bin-path: //")

PATH=$(perl -e "$PATH_FIX" "$HOME_BIN" "$HASK_BIN" "$PERL_BIN" "$RUBY_BIN" \
  "$CLUA_BIN" "$GO_L_BIN" "$PATH")

BROWSER=firefox
EDITOR=nvim
EMSCRIPTEN_ROOT=/usr/lib/emscripten
GOPATH=$HOME/.go
LLVM_ROOT=/usr/bin
LUA_CPATH=$(luarocks path --lr-cpath)
LUA_PATH=$(luarocks path --lr-path)
NODE_JS=/usr/bin/node
PAGER=less
VISUAL=nvim
XDG_CONFIG_HOME=$HOME/.config

PERL5LIB="$HOME/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
PERL5OPT="-I$HOME/.perl5/lib/perl5 -I$HOME/.perl5/lib/perl5/site_perl"
PERL_LOCAL_LIB_ROOT="$HOME/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
PERL_MB_OPT="--install_base \"$HOME/.perl5\""
PERL_MM_OPT="INSTALL_BASE=$HOME/.perl5"

if [ ! "$(pidof transmission-daemon)" ]
then
    transmission-daemon &
fi

BASHRC=$HOME/.bashrc

if [ -x "$BASHRC" ]
then
  # shellcheck disable=SC1090
  . "$BASHRC"
fi
