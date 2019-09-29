A fork of: https://github.com/linuxserver/docker-baseimage-alpine

Image size: 19,5 MB

Added: repository: edge(main, community and testing)
       
Package list:
alpine-baselayout-3.1.2-r0 - Alpine base dir structure and init scripts
alpine-keys-2.1-r2 - Public keys for Alpine Linux packages
apk-tools-2.10.4-r2 - Alpine Package Keeper - package manager for alpine
bash-5.0.0-r0 - The GNU Bourne Again shell
busybox-1.30.1-r2 - Size optimized toolbox of many common UNIX utilities
ca-certificates-20190108-r0 - Common CA certificates PEM files
ca-certificates-cacert-20190108-r0 - Mozilla bundled certificates
coreutils-8.31-r0 - The basic file, shell and text manipulation utilities
libacl-2.2.52-r6 - Dynamic library for access control list support
libattr-2.4.48-r0 - Utilities for managing filesystem extended attributes (libraries)
libc-utils-0.7.1-r0 - Meta package to pull in correct libc
libcrypto1.1-1.1.1d-r0 - Crypto library from openssl
libssl1.1-1.1.1d-r0 - SSL shared libraries
libtls-standalone-2.9.1-r0 - libtls extricated from libressl sources
linux-pam-1.3.0-r1 - pluggable authentication modules for linux
musl-1.1.22-r3 - the musl c library (libc) implementation
musl-utils-1.1.22-r3 - the musl c library (libc) implementation
ncurses-libs-6.1_p20190518-r0 - Ncurses libraries
ncurses-terminfo-6.1_p20190518-r0 - Console display library (other terminfo files)
ncurses-terminfo-base-6.1_p20190518-r0 - Descriptions of common terminals
readline-8.0.0-r0 - GNU readline library
scanelf-1.2.3-r0 - Scan ELF binaries for stuff
shadow-4.6-r2 - PAM-using login and passwd utilities (usermod, useradd, ...)
ssl_client-1.30.1-r2 - EXternal ssl_client for busybox wget
tzdata-2019b-r0 - Timezone data
xz-5.2.4-r0 - Library and CLI tools for XZ and LZMA compressed files
xz-libs-5.2.4-r0 - Library and CLI tools for XZ and LZMA compressed files (libraries)
zlib-1.2.11-r1 - A compression/decompression Library

&nbsp;
&nbsp;

[![](https://images.microbadger.com/badges/image/lsiobase/alpine.svg)](https://microbadger.com/images/lsiobase/alpine "Get your own image badge on microbadger.com")

[![](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/Dockerfile-Link-green.png)](https://github.com/linuxserver/docker-baseimage-alpine/blob/master/Dockerfile)

A custom base image built with [Alpine linux][appurl] and [S6 overlay](https://github.com/just-containers/s6-overlay)..

The following line is only in this repo for loop testing:

- { date: "01.01.50:", desc: "I am the release message for this internal repo." }
