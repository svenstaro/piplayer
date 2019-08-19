#!/bin/bash

set -eux

export ALSA_LIB_VERSION="1.1.9"
export PACKAGE="alsa-lib-${ALSA_LIB_VERSION}"

SYSROOT=/tmp/piplayer-cross
mkdir -p ${SYSROOT}
wget -c -P ${SYSROOT} ftp://ftp.alsa-project.org/pub/lib/${PACKAGE}.tar.bz2
tar xf ${SYSROOT}/${PACKAGE}.tar.bz2 -C ${SYSROOT}
cd ${SYSROOT}/${PACKAGE}
export PATH=${PATH}:/opt/x-tools/x-tools7h/arm-unknown-linux-gnueabihf/bin/
./configure --host=arm-unknown-linux-gnueabihf --target=arm-unknown-linux-gnueabihf
make -j$(nproc)
make DESTDIR=${SYSROOT} install

cd -
export PKG_CONFIG_DIR=
export PKG_CONFIG_LIBDIR=${SYSROOT}/usr/lib/pkgconfig
export PKG_CONFIG_SYSROOT_DIR=${SYSROOT}
export PKG_CONFIG_ALLOW_CROSS=1
export CC=/opt/x-tools/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-gcc
export CC_target=/opt/x-tools/x-tools7h/arm-unknown-linux-gnueabihf/bin/arm-unknown-linux-gnueabihf-gcc
cargo build --release --target armv7-unknown-linux-gnueabihf
ssh mouse "rm ~/piplayer"
scp target/armv7-unknown-linux-gnueabihf/release/piplayer mouse:piplayer
ssh mouse "systemctl --user restart piplayer"
