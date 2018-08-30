#!/bin/sh -x

# Disable original S-d
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Primary><Super>d', '<Primary><Alt>d']"
# TODO: the rest of the disables.

# maybe: q w e r a s d f c v
i=0
for key in q w e r a s d f; do
    i=$((i + 1))
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$key']"
    gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Shift><Super>$key']"
done


# # ...
# gsettings set org.gnome.desktop.background picture-uri file://...

# # disable the gnome keyboard management to use Xkb
# # https://github.com/ierton/xkb-switch/issues/15
# gsettings set org.gnome.settings-daemon.plugins.keyboard active false
# gsettings set org.gnome.desktop.input-sources sources '[]'
# # gsettings set org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'ru')]"
