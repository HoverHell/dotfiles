# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything:
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

# some more ls aliases
alias ll='ls -lAF'
#alias la='ls -A'
#alias l='ls -CF'
alias l='ls -CAF'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#alias wine='LANG=ru_RU.UTF-8 wine'

#alias mcd='eject -t; mount /cdrom; cd /cdrom'
#alias ucd='umount /cdrom; eject'
#alias mfl='mount /media/sda1; mount /media/sdb1; mount /media/sdc1; cd /media/sda1'
#alias ufl='umount /media/sda1; umount /media/sdb1; umount /media/sdc1'

#alias hibernate='date; sudo hibernate; date'
#alias mpl='mplayer -fs'

#alias s2disk='sudo s2disk'
#alias s2ram='sudo s2ram'
#alias s2both='sudo s2both'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#xterm-color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#    ;;
#*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#    ;;
#esac

# Comment in the above and uncomment this below for a color prompt
#PS1="${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[00;37m\]@\[\033[00;32m\]\h\[\033[01;37m\]:\[\033[01;36m\]\w\[\033[01;37m\]\$ "
PS1="${debian_chroot:+($debian_chroot)}\[\033[40m\033[0m\033[01;33m\]\u\[\033[00;37m\]@\[\033[01;37m\]\h\[\033[00;37m\]:\[\033[01;36m\]\w\[\033[00;37m\033[00m\]\$ "

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profiles
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#PAGER="most"
#LANG="C"
#export LC_CTYPE="ru_RU.CP1251"
#export LC_NUMERIC="ru_RU.CP1251"
#export LC_TIME="en_US"
#export LC_COLLATE="ru_RU.CP1251"
#export LC_MONETARY="ru_RU.CP1251"
#export LC_PAPER="ru_RU.CP1251"
#export LC_NAME="ru_RU.CP1251"
#export LC_ADDRESS="ru_RU.CP1251"
#export LC_TELEPHONE="ru_RU.CP1251"
#export LC_MEASUREMENT="ru_RU.CP1251"
#export LC_IDENTIFICATION="ru_RU.CP1251"
#export LANG="en_US"
#export LANGUAGE="en_US"
#export LC_MESSAGES="en_US"
#export GDK_USE_XFT=0
#export QT_XFT=0
#export COLUMNS=132
#DEFAULTCHARSET="CP1251"

if [ -f /usr/share/doc/cdargs/examples/cdargs-bash.sh ]; then
  . /usr/share/doc/cdargs/examples/cdargs-bash.sh
fi

export BROWSER="/usr/bin/x-www-browser"
# Extra completions
complete -o filenames -F _command s-  # mscreenterm run cmd
. ~/bin/webtap.bash_completion

export HISTTIMEFORMAT="%s "
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER \
               "$(history 1)" >> ~/.bash_eternal_history'

shopt -s histappend

