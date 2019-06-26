#!/bin/bash

# get ubuntu main version
ubuntu_version=$(cat /etc/issue | awk '{print $2}' | cut -d'.' -f1)

# required software modules to build iad software
apt-get -y install build-essential software-properties-common
apt-get -y install byobu curl htop man
apt-get -y install flex bison tcl tcl8.4 xsltproc
apt-get -y install g++ squashfs-tools libtool libneon27-gnutls libncurses-dev
apt-get -y install tofrodos libxml2-utils
apt-get -y install quilt graphviz expat diffstat autopoint
apt-get -y install zlibc zlib1g zlib1g-dev
apt-get -y install lzop libexpat1-dev
apt-get -y install sharutils mtd-utils
apt-get -y install bin86 libstdc++5 libstdc++6-4.6-dev
apt-get -y install gtk-doc-tools xutils-dev libdbus-1-dev
apt-get -y install gawk

# new build-system
apt-get -y install python3-yaml

if [[ ${#ubuntu_version} -gt 0 ]] && [[ "${ubuntu_version}" -ge 16 ]]; then
    apt-get -y install libtool-bin
fi

# autoconf (for reading/generate configure scripts
apt-get -y install m4 autoconf

# automake
apt-get -y install automake autotools-dev

if [ "$(uname -m)" = "x86_64" ]; then
    # install 32 bit libraries
    if [[ ${#ubuntu_version} -gt 0 ]] && [[ "${ubuntu_version}" -lt 14 ]]; then
        apt-get -y install ia32-libs
    else
        apt-get -y install lib32z1 lib32ncurses5 lib32bz2-1.0

        dpkg --add-architecture i386
        apt-get update
        apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386
    fi
fi

