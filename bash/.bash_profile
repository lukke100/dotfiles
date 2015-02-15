PATH="$HOME/.local/bin:$HOME/.cabal/bin:"$PATH
eval `luarocks path`
PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
export ECLIPSE_HOME="/usr/share/eclipse"

if [ ! "$(pidof transmission-daemon)" ];
then transmission-daemon &
fi

if [ ! "$(pidof dropbox)" ];
then dropbox &
fi

if [ ! "$(pidof eclimd)" ];
then "$ECLIPSE_HOME/eclimd" "-Dosgi.instance.area.default=@user.home/work" &
fi

umask 077

[[ -r ~/.bashrc ]] && . ~/.bashrc
