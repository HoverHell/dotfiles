
## The Terminal
~/bin/xmrescreen &

## Configs
xrdb -merge "$HOME/.Xdefaults"

## Systems, wallpapers...
# eterm's Esetroot does something that makes the right image show in
# transparent terminals.
#Esetroot /home/hell/files/currwallp

## Screen locking and optional eyecandy
#xscreensaver -no-splash &


## Stats and stuffs
#conky -d  # simple.
## Somewhat-xmonad-specific:
#trayer --edge top --align right --SetDockType true --SetPartialStrut true \
#  --expand true --width 10 --transparent true --tint 0x191970 --height 12 &
#stalonetray & 
#nm-applet --sm-disable &
# gnome-power-manager &


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
#xbindkeys &

## openbox-relevant mostly
~/bin/setlayout 0 2 2 0

## Actual autostarts with screen-attachment.
## (some can be put into screenrc for screentermy0, actually)
sleep 15 && s0- pa1 &  # pulseaudio
sleep 15 && s0- synergyc1 &  # <- has to be X-specific
# sleep 15 && s0- hhrr &

## The Hardcore Keyboard Layout.
xkbcomp $HOME/.xkb_config $DISPLAY 2> /dev/null

## The WM
#exec /usr/bin/openbox
#exec /usr/bin/awesome
#exec /usr/bin/xmonad
#exec "$HOME"/bin/xmonad  # darcs version.
