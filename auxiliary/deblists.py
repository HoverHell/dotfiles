#!/usr/bin/env python3

import datetime
import os
import shutil
import subprocess
import sys
import tempfile


class Deblists:

    common = '''
    apt-transport-https  # extra layer for privacy, sometimes required
    '''

    common_net = '''
    # For working with other systems both interactively and non-interactively.
    curl  # commonly necessary
    wget  # commonly necessary
    rsync  # also useful for rsyncing *to* the system
    '''

    cli = '''
    ### Interactive shell local system tools ###

    # # Shell set:
    busybox-static
    bash  # in case it isn't there somehow
    bash-completion  # more convenience
    cdargs

    # # Toolset:
    apg  # password generator
    bc  # quick calculator
    bsdmainutils  # `ncal`, `hd`
    devscripts  # annotate-output debuild ...
    # `.deb` direct installation.
    # Should, generally, only be useful for installing deblists themselves.
    # gdebi-core
    grep
    gnupg
    jq  # JSON processing
    moreutils  # pee sponge ...
    rename  # filename-editing
    strace  # executing with details
    ltrace
    time  # exetuting with timing
    # uuid  # uuid generation. rare.

    git  # a multi-category thing
    # fossil
    diffutils
    colordiff  # diff for eyes
    wdiff  # diff for eyes (too)

    lsof
    smartmontools

    # # TUIs:
    mc  # file management
    screen  # terminal multiplexer, backgrounder
    htop iotop
    less
    nano
    joe-jupp
    # zile
    # emacs-nox
    '''

    cli_net = '''
    ### Interactive shell networked tools ###

    lynx  # HTTP/HTML processing
    w3m  # HTTP/HTML processing
    # youtube-dl  # usually makes sense to install from `master`
    socat  # TCP/UDP debug/tooling
    nmap  # goes as network debug too
    bind9-host  # DNS debug
    iputils-ping
    iputils-tracepath
    mtr-tiny
    tcpdump
    dnsutils  # `dig`
    openssh-client  # ...
    netcat-openbsd  # ...
    bing  # network bandwidth testing
    iproute2  # `ip ...`
    iftop

    # git-svn git-remote-hg git-remote-bzr
    '''

    host_common = '''
    autossh  # ssh proxying / centralizing
    openssh-server
    '''

    build = '''
    build-essential  cmake  autoconf  automake  make
    shellcheck  pkg-config llvm
    libc6-dev  libffi-dev  libncurses5-dev  libncursesw5-dev  libgdbm-dev
    libreadline-dev  tk-dev
    libsqlite3-dev  openssl
    zlib1g-dev  libbz2-dev  libzip-dev  liblzma-dev  xz-utils
    libxml2-dev  libxmlsec1-dev
    libboost-all-dev
    lua5.2  liblua5.2-dev
    libtbb-dev

    libcap-dev libcurl4-nss-dev libpq-dev libfreetype6-dev
    libpng-dev liblapack-dev libblas-dev libssl-dev
    python3.9 python3.9-venv python3.9-dev
    '''

    file_formats = '''
    sqlite3
    p7zip-full
    unp  # combining auto-unarchiver
    catdoc
    cuetools
    dosfstools
    '''

    main_system = '''
    # Persistent-system management
    aptitude  # Best-hope for when dependencies get a little complicated.
    apt-file  # Goes as a common database for deb packages
    wipe  # not usually effective, but better than nothing.
    etckeeper  # persistent /etc history
    cruft-ng  # non-deb-tracked files
    debsums  # non-deb-matching files
    borgbackup  # ...
    duff  # duplicates
    easy-rsa
    # Encrypted root fs:
    ecryptfs-utils  cryptsetup  cryptsetup-bin
    # ...
    encfs

    mosh  # ssh convenience in case of a bad connection
    sshfs  # ssh convenience in case of a good connection
    # dvcs-autosync
    # davfs2  # rare, currently.

    at  # ...

    # ...
    aspell
    aspell-en

    docker.io
    '''

    main_system_x = '''
    ### Graphical-entrypoint stuff ###
    xclip
    arandr
    ark
    antiword
    chromium-browser firefox firejail
    dmz-cursor-theme
    # kgraphviewer
    rxvt-unicode
    # rxvt-unicode-256color
    xkbset xbindkeys
    geeqie mplayer vlc
    i3 stalonetray xpra remmina
    '''

    main_system_hw = '''
    ### Hardware-entrypoint stuff ###
    # bluedevil blueman bluez
    cheese
    cups
    eject
    lshw
    hdparm
    powertop
    fancontrol hddtemp i2c-tools lm-sensors
    irqbalance
    lvm2
    '''

    main_system_ubu = '''
    # ubuntu-desktop-minimal
    # ubuntu-desktop
    kubuntu-desktop
    kubuntu-restricted-addons
    linux-generic-hwe-20.04
    xen-system-amd64
    '''

    main_system_all = '''
    hdeps-common hdeps-common-net hdeps-cli hdeps-cli-net
    hdeps-host-common
    hdeps-build hdeps-file-formats
    hdeps-main-system hdeps-main-system-x hdeps-main-system-hw hdeps-main-system-ubu
    '''

    dev_max = '''
    # C++ IDEs. WIP.
    qtcreator codeblocks codeblocks-contrib codelite codelite-plugins kdevelop anjuta
    # C++ tools
    codequery codespell cppcheck-gui kdiff3 kompare meld clazy
    # C++
    clang-7 clang-7-doc clang-7-examples
    clang-8 clang-8-doc clang-8-examples
    # Python
    python3.9 python3.9-dev python3.9-venv
    pythontracer games-python3-dev eric ninja-ide
    # other additions
    fonts-mathjax-extras fonts-stix
    '''

    virtualbox_guest = '''
    virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
    '''


def _parse(value):
    lines = value.strip().splitlines()
    lines = [line.split('#', 1)[0].strip() for line in lines]
    items = [item for line in lines for item in line.split() if item]
    return set(items)


DEBSETS = {
    name: _parse(value)
    for name, value in Deblists.__dict__.items()
    if isinstance(value, str) and not name.startswith('_')
}


def printout():
    sets = DEBSETS
    if len(sys.argv) > 1:
        pkgs = {
            pkg
            for key in sys.argv[1:]
            for pkg in sets[key]
        }
        print('  '.join(sorted(pkgs)))
    else:
        print('\n'.join(
            name + ':    ' + ' '.join(sorted(pkgs)) + '\n'
            for name, pkgs in sets.items()
        ))



def _run(*args, **kwargs):
    return subprocess.check_call(args, **kwargs)


CONTROL_TPL = """
Package: hdeps-{name_dash}
Version: 1.0-{now}
Architecture: all
Maintainer: hoverhell <hoverhell@localhost>
Depends: {deps_comma}
Priority: optional
Description: h system dependencies {name_underscore}
 This package depends on all of the packages
 listed as '{name_underscore}'
""".lstrip()


def build_one_i(pkg_set_name, target_dir):
    pkg_set_name_dash = pkg_set_name.replace('_', '-')
    pkg_name = f'hdeps-{pkg_set_name_dash}'
    deb_dir = os.path.join(pkg_name, 'DEBIAN')
    control = CONTROL_TPL.format(
      name_dash=pkg_set_name_dash,
      name_underscore=pkg_set_name,
      now=datetime.datetime.now().strftime('%Y%m%d%H%M%S'),
      deps_comma=', '.join(DEBSETS[pkg_set_name]),
    )

    os.mkdir(pkg_name)
    os.mkdir(deb_dir)
    with open(os.path.join(deb_dir, 'control'), 'w') as fobj:
        fobj.write(control)
    _run('dpkg', '-b', pkg_name)
    debfile = f'{pkg_name}.deb'
    assert os.path.exists(debfile), 'should have been created by dpkg'
    shutil.copy(debfile, os.path.join(target_dir, debfile))


def build_one(pkg_set_name):
    main_dir = os.path.realpath('.')
    try:
        with tempfile.TemporaryDirectory(prefix='hdfpb_') as tempdir:
            os.chdir(tempdir)
            build_one_i(pkg_set_name, target_dir=main_dir)
    finally:
        os.chdir(main_dir)


def build():
    repo_path = '/usr/local/etc/hdeps'
    cfg_path = '/etc/apt/sources.list.d/hdeps.list'
    os.makedirs(repo_path, exist_ok=True)
    os.chdir(repo_path)
    for pkg_set_name in DEBSETS:
        build_one(pkg_set_name)
    _run('sh', '-x', '-c', 'dpkg-scanpackages -m . | gzip > Packages.gz')
    with open(cfg_path, 'w') as fobj:
        fobj.write(f'deb [trusted=yes] file:{repo_path} /\n')
    _run('apt', 'update')


def main():
    build()
    printout()


if __name__ == '__main__':
    main()
