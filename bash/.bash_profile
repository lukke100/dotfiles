PATH="$HOME/.local/bin:$HOME/.cabal/bin:$PATH"
PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
PATH="$HOME/perl5/bin${PATH+:}${PATH}"
eval `luarocks path`;
ECLIPSE_HOME="/usr/share/eclipse";

if [ ! "$(pidof transmission-daemon)" ];
then transmission-daemon &
fi

umask 077

[[ -r ~/.bashrc ]] && . ~/.bashrc

