FROM rustembedded/cross:armv7-unknown-linux-gnueabihf-0.2.1
RUN dpkg --add-architecture armhf && \
    apt-get update && \
    apt-get -y install libasound2-dev libasound2-dev:armhf ffmpeg
ENV PKG_CONFIG_LIBDIR=/usr/lib/arm-linux-gnueabihf/pkgconfig
ENV PKG_CONFIG_SYSROOT_DIR=/usr/lib/arm-linux-gnueabihf
ENV PKG_CONFIG_ALLOW_CROSS=1
ENV PKG_CONFIG_LIBDIR=/usr/lib/arm-linux-gnueabihf/pkgconfig
