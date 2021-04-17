.PHONY: all
all: docker cross

.PHONY: docker
docker:
	docker build -t cross:armv7-unknown-linux-gnueabihf-custom .

.PHONY: cross
cross:
	cross build --release --target armv7-unknown-linux-gnueabihf
	# PKG_CONFIG_DIR= PKG_CONFIG_LIBDIR=/usr/lib/arm-linux-gnueabihf/pkgconfig PKG_CONFIG_SYSROOT_DIR=/usr/lib/arm-linux-gnueabihf PKG_CONFIG_ALLOW_CROSS=1 cross build --release --target armv7-unknown-linux-gnueabihf
