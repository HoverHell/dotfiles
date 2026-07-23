# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# # For debugging this file:
# set -x

# If not running interactively, don't do anything:
if [ -z "$PS1" ]; then return; fi

# This duplicated the `.profile` code, currently.
# # http://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
_pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}
_pathadd "$HOME/.local/bin"
_pathadd "$HOME/.local/usr/bin"
_pathadd "$HOME/bin"

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi

# Minor non-subprocessable conveniences.
realcd() { cd "$(realpath "$(pwd)")"; }

# # CFG and local overrides
CFG_ps_time="1"  # timestamp in PS. empty to disable
CFG_ps_ret="1"  # "$?" in PS. empty to disable
CFG_ps_u="1;32"  # PS user color
CFG_ps_h="0;33"  # PS host color
if [ -f ~/.bashrc_local ]; then . ~/.bashrc_local; fi

# # don't put duplicate lines in the history. See bash(1) for more options
# export HISTCONTROL=ignoredups

if [ x"${TERM_ACTUAL:-""}" == x"rxvt-256color" ]; then
    export TERM="xterm-256color"
fi

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# LS_PARAMS="--time-style=long-iso"
LS_PARAMS="--time-style=iso"

# Enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "$(dircolors -b)"
    LS_PARAMS="$LS_PARAMS --color=auto"
fi

alias ls="ls \$LS_PARAMS"
# Some more ls aliases
alias ll="ls -lAF"
alias l="ls -CAF"
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-""}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# # set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
#     xterm-color)
# 	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# 	;;
#     *)
# 	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# 	;;
# esac

# # Comment in the above and uncomment this below for a color prompt
# PS1="${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[00;37m\]@\[\033[00;32m\]\h\[\033[01;37m\]:\[\033[01;36m\]\w\[\033[01;37m\]\$ "

# Build PS1 and also have some color-sequences in variables.
c_start='\['
c_end='\]'
c_reset='\033[0m'
# "cf" as in "color, full sequence"
cf_reset="${c_start}${c_reset}${c_end}"
c_white_reset='\033[0;1;37m'
cf_white_reset="${c_start}${c_white_reset}${c_end}"
c_cyan='\033[1;36m'
PS1=""
PS1="${PS1}${debian_chroot:+($debian_chroot)}"
if [ $CFG_ps_time ]; then
    PS1="${PS1}${cf_white_reset}| \\D{%H%M%S} "
else
    PS1="${PS1}${cf_reset}"
fi
c_user="\\033[${CFG_ps_u}m"
PS1="${PS1}${c_start}${c_user}${c_end}\\u${cf_reset}"
c_host="\\033[${CFG_ps_h}m"
PS1="${PS1}@${c_start}${c_host}${c_end}\\h${cf_reset}"
PS1="${PS1}:${c_start}${c_cyan}${c_end}\\w${cf_reset}"
if [ $CFG_ps_ret ]; then PS1="${PS1}:\$?"; fi
PS1="${PS1}\\\$ "

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


# # cdargs (`cv`, `ca`, ...).
if [ -f /usr/share/doc/cdargs/examples/cdargs-bash.sh ]; then
    . /usr/share/doc/cdargs/examples/cdargs-bash.sh
fi
if [ -f /usr/share/cdargs/cdargs-bash-completion.sh ]; then  # cygwin
    . /usr/share/cdargs/cdargs-lib.sh
    . /usr/share/cdargs/cdargs-alias.sh
    CDARGS_BASH_ALIASES="cv cdb"
    alias cv="cdb"
    . /usr/share/cdargs/cdargs-bash-completion.sh
fi



# # History-keeping `cd`:
# # http://unix.stackexchange.com/questions/4290/
pushd() {
    if [ $# -eq 0 ]; then
      DIR="${HOME}"
    else
      DIR="$1"
    fi

    builtin pushd "${DIR}" > /dev/null
    dirs >&2
}
pushd_builtin() {
    builtin pushd > /dev/null
    dirs >&2
}
popd() {
    builtin popd > /dev/null
    dirs >&2
}
alias cd="pushd"
alias flip="pushd_builtin"


# export BROWSER="/usr/bin/x-www-browser"
# export EDITOR="jmacs"


# # Extra completions
complete -o filenames -F _command s-  # mscreenterm run cmd
# if [ -f ~/.local/bin/webtap.bash_completion ]; then . ~/.local/bin/webtap.bash_completion; fi


# # Bash-eternal-history
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER "$(history 1)" >> ~/.bash_eternal_history'
# ...
shopt -s histappend
export HISTTIMEFORMAT="%Y-%m-%dT%H:%M:%S%z "
# export HISTFILE="/dev/null"

# # fixes 'echo "!"' problem.  Use interactive hotkeys for run-from-history.
set +o histexpand

# bind -r '\en'  # removes the binding for escape-n, but the reason if forgotten

# Ensure the prompt starts from the beginning of a line (with a bit of disambiguation).
# But not under `mc` (as it seems to break somehow).
__ensure_newline() {
    local _row _prefix column read_status tty_settings

    if [[ ! -t 0 ]]; then return; fi  # only if stdin is tty
    if [[ ! -t 1 ]]; then return; fi  # only if stdout is tty

    # Canonical mode hides an unsubmitted keystroke from read's readiness check.
    # `-g` as in `--save` as in "dump the settings".
    tty_settings=$(stty -g) || return
    # disable canonical input processing "special characters: erase, kill, werase, rprnt"
    # "set 0 characters minimum for a completed read"
    stty -icanon min 0 time 0 || return
    IFS="" read -t 0
    # NOTE: input arriving after this command will not be handled.
    read_status=$?
    # Restore the settings.
    stty "$tty_settings"
    # Input pending. Ensure PS1 starts from a new line.
    if (( read_status == 0 )); then printf '\n%s\n' "${BASHRC_TTY_MARKER:-<<<}"; return; fi

    # Read the cursor position.
    # `-r`aw, `-s`ilent, `-d`elimiter `-t`imeout `-p`rompt
    IFS='[;' read -r -s -d R -t 0.25 -p $'\e[6n' _prefix _row column || return
    if [[ $column != 1 ]]; then printf '\n%s\n' "${BASHRC_TTY_MARKER:-<<<}"; fi
}
if [ -z "$MC_SID" ]; then
    PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'__ensure_newline'
fi


# Fix for encfs/alike homedir problems.
if pwd | grep -q '^(unreachable)'; then
    echo "pwd: '$(pwd)'; \`cd\`..."
    cd "$HOME"
fi

if [ -f ~/.virtualenv/bin/activate ]; then
    . ~/.virtualenv/bin/activate
fi
export PYTHONBREAKPOINT=ipdb.set_trace

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$("$HOME/miniconda3/bin/conda" shell.bash hook 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "$HOME/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="$HOME/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<

# fnm (nodejs version manager)
if [ -f "$HOME/.fnm/fnm" ]; then
    _pathadd "$HOME/.fnm"
    eval "$(fnm env)"
fi

# nix package manager
if [ -e /home/hell/.nix-profile/etc/profile.d/nix.sh ]; then
    . /home/hell/.nix-profile/etc/profile.d/nix.sh
    _pathadd "$HOME/.nix-profile/bin"
fi

# Transition compat for broken debian packages' bash completion
if ! command -v _split_longopt; then _split_longopt() { _comp__split_longopt "$@"; }; fi

true
