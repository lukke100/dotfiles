#!/bin/bash
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -load ~/.Xresources
xsetroot -cursor_name left_ptr
eval $(cat ~/.fehbg)
xscreensaver -no-splash &
compton &
# Disabled for now (there are bugs)
# stalonetray &
redshift -l 45.0:-75.0 &
unclutter -idle 10 -noevents & # "-noevents" prevents issues with Firefox
wmname LG3D
dex -a -e xmonad
rofi &

if [ ! "$(pidof eclimd)" ];
then "$ECLIPSE_HOME/eclimd" "-Dosgi.instance.area.default=@user.home/work" &
fi

exec xmonad
