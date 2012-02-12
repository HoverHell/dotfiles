
## The Terminal
~/bin/xmrescreen &

## Systems, wallpapers...
#Esetroot /home/hell/files/currwallp

## Screen locking and optional eyecandy
#xscreensaver -no-splash &

## Stats and stuffs
#conky -d

## Old Old Crap Crap
#lxterm -e 'tail -n 0 -f "$HOME/dmenu.log" "$HOME/dmenu.err.log" "$HOME/launch.log" "$HOME/xstart.log" "/var/log/syslog"' &
#xxkb &
# imwheel
#ulimit -c unlimited
#stardict &
#tilda &
#~/bin/xrescreen &
#~/bin/allnotes &
#irexec &
# xh2

## openbox-relevant mostly
~/bin/setlayout 0 2 2 0

## Actual autostarts with screen-attachment.
## (some can be put into screenrc for screentermy0, actually)
sleep 15 && s0- pa1 &
sleep 15 && s0- synergyc1 &
# sleep 15 && s0- hhrr &

## The Hardcore Keyboard Layout.
xkbcomp $HOME/.xkb_config $DISPLAY 2> /dev/null

## The WM
exec /usr/bin/openbox
#exec /usr/bin/awesome
#exec /usr/bin/xmonad
