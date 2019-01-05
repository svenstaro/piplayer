#!/bin/bash

set -eux

SYSROOT=/tmp/alarm
mkdir -p ${SYSROOT}
PACKAGE=alsa-lib-1.1.7-2-armv7h.pkg.tar.xz
wget -q -c -P ${SYSROOT} http://mirror.archlinuxarm.org/armv7h/extra/${PACKAGE}
tar xf ${SYSROOT}/${PACKAGE} -C ${SYSROOT} 2>/dev/null

export PKG_CONFIG_DIR=
export PKG_CONFIG_LIBDIR=${SYSROOT}/usr/lib/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=${SYSROOT}
export PKG_CONFIG_ALLOW_CROSS=1
export CC=/opt/x-tools/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-gcc
export CC_target=/opt/x-tools/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-gcc
cargo build --release --target armv7-unknown-linux-gnueabihf
scp target/armv7-unknown-linux-gnueabihf/release/piplayer mouse:/tmp/piplayer/piplayer
