# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	      . "$HOME/.bashrc"
    fi
fi

# http://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
_pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    _pathadd "$HOME/bin"
fi
if [ -d "$HOME/.local/bin" ] ; then
    _pathadd "$HOME/.local/bin"
fi
if [ -d "$HOME/.local/usr/bin" ] ; then
    _pathadd "$HOME/.local/usr/bin"
fi
