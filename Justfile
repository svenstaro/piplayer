set dotenv-load := true

build-native:
    cargo build --release -vv

build-cross:
    cross build --release -vv --target armv7-unknown-linux-gnueabihf

image:
    $CROSS_CONTAINER_ENGINE build -t cross:armv7-unknown-linux-gnueabihf-custom .
