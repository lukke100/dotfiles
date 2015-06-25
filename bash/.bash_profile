PATH=$HOME/.local/bin:$PATH
PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
PATH=$HOME/perl5/bin${PATH+:}${PATH}
PATH=$(stack path | grep '^bin-path: ' | sed 's/^bin-path: //')
eval `luarocks path`;

if [ ! "$(pidof transmission-daemon)" ];
then transmission-daemon &
fi

umask 077

[[ -r ~/.bashrc ]] && . ~/.bashrc

